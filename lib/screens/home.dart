import 'dart:convert';

import 'package:covidnearby/components/card.dart';
import 'package:covidnearby/components/graph.dart';
import 'package:covidnearby/components/label.dart';
import 'package:covidnearby/models/covid_data.dart';
import 'package:covidnearby/models/brazil_data.dart';
import 'package:covidnearby/models/br_state.dart';
import 'package:covidnearby/models/covid_request.dart';
import 'package:covidnearby/utils/network_helper.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class HomeScreen extends StatelessWidget {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Future<Map<String, dynamic>> _initApp(BuildContext context) async {
    List<BRState> states;
    Placemark userLocation;
    CovidData covidData;
    CovidData stateData;
    BrazilData brazilData;

    try {
      String statesRawData = await DefaultAssetBundle.of(context).loadString('assets/data/br_states.json');
      List<dynamic> statesParsedData = jsonDecode(statesRawData);
      states = statesParsedData.map((json) => BRState.fromJson(json)).toList();

      Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      List<Placemark> locations = await geolocator.placemarkFromCoordinates(position.latitude, position.longitude);
      userLocation = locations[0];

      BRState state = states.firstWhere((state) => state.name == userLocation.administrativeArea);
      String county = state.counties.firstWhere((county) => county == userLocation.subAdministrativeArea);

      covidData = await CovidRequest(state.abbreviation, county).getFullCases();
      stateData = await CovidRequest(state.abbreviation, county).getStateCases();

      print(userLocation.toJson());
      print(covidData.city);
      print(covidData.date);

      NetworkHelper netHelper = NetworkHelper(url: 'https://corona-api.com/countries/BR');
      brazilData = BrazilData.fromJson((await netHelper.getData())['data']);

      print(brazilData.latestData.confirmed);
      print(brazilData.latestData.recovered);
      print(brazilData.latestData.deaths);

      print(brazilData.timeline[0].date);
      print(brazilData.timeline[1].date);
      print(brazilData.timeline[2].date);
      print(brazilData.timeline[3].date);

    } catch (e) {
      print(e);
    }

    return {
      'states': states,
      'userLocation': userLocation,
      'covidData': covidData,
      'stateData': stateData,
      'brazilData': brazilData
    };
  }

  @override
  Widget build(BuildContext context) {
    List<BRState> states;
    Placemark userLocation;
    CovidData covidData;
    CovidData stateData;
    BrazilData brazilData;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sua região"),
      ),
      body: FutureBuilder(
        future: _initApp(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 10,),
                    Text('Carregando...'),
                  ],
                )
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              states = snapshot.data['states'];
              userLocation = snapshot.data['userLocation'];
              covidData = snapshot.data['covidData'];
              stateData = snapshot.data['stateData'];
              brazilData = snapshot.data['brazilData'];

              if (states == null || userLocation == null || covidData == null) {
                return Text('Não foi possível carregar as informações necessárias. Verifique sua conexão.');
              }

              return _homeBody(context, covidData, stateData, brazilData);
              break;
          }

          return Text('Erro desconhecido. Tente reiniciar o aplicativo.');
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _homeFavoriteFAB(context),
      ]),
      bottomNavigationBar: _homeBNB(context),
    );
  }

//  _homeBody(BuildContext context) {
//    return Center(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          FlatButton(
//            child: Text("Get location"),
//            onPressed: () {},
//          ),
//        ],
//      ),
//    );
//  }

  _homeBody(BuildContext context, CovidData covidData, CovidData stateData, BrazilData brazilData) {
    return ListView(
      children: <Widget>[
        CardCovid(
          confirmados: "${covidData.lastAvailableConfirmed} (+${covidData.newConfirmed})",
          fatais: "${covidData.lastAvailableDeaths} (+${covidData.newDeaths})",
          mortalidade: "${(covidData.lastAvailableDeathRate * 100).toStringAsFixed(2)}%",
          titulo: covidData.city,
        ),
        SizedBox(height: 15,),
        CardCovid(
          confirmados: "${stateData.lastAvailableConfirmed} (+${stateData.newConfirmed})",
          fatais: "${stateData.lastAvailableDeaths} (+${stateData.newDeaths})",
          mortalidade: "${(stateData.lastAvailableDeathRate * 100).toStringAsFixed(2)}%",
          titulo: stateData.state,
        ),
        SizedBox(height: 15,),
        CardCovid(
          confirmados: "${brazilData.latestData.confirmed} (+${brazilData.timeline[0].newConfirmed})",
          fatais: "${brazilData.latestData.deaths} (+${brazilData.timeline[0].newDeaths})",
          mortalidade: "${brazilData.latestData.calculated.deathRate.toStringAsFixed(2)}%",
          titulo: "Brasil",
        ),
        SizedBox(height: 15,),
        Center(child: Text("Casos no Brasil")),
        SizedBox(
          height: 250,
          child: CovidGraph(brazilData),
        ),
        SizedBox(
          height: 75,
          child: Column(
            children: [
              SizedBox(height: 5),
              Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Label("Confirmados", Colors.blue),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Label("Recuperados", Colors.green),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Label("Mortes", Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _homeBNB(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Início"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text("Favoritos"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("Pesquisar"),
        )
      ]
    );
  }

  _homeFavoriteFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.favorite),
    );
  }
}
