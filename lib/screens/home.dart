import 'dart:convert';

import 'package:covidnearby/models/covid_data.dart';
import 'package:covidnearby/models/br_state.dart';
import 'package:covidnearby/models/covid_request.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Future<Map<String, dynamic>> _initApp(BuildContext context) async {
    List<BRState> states;
    Placemark userLocation;
    CovidData covidData;

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

      print(userLocation.toJson());
      print(covidData.city);
      print(covidData.date);
    } catch (e) {
      print(e);
    }

    return {
      'states': states,
      'userLocation': userLocation,
      'covidData': covidData
    };
  }

  @override
  Widget build(BuildContext context) {
    List<BRState> states;
    Placemark userLocation;
    CovidData covidData;

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

              if (states == null || userLocation == null || covidData == null) {
                return Text('Não foi possível carregar as informações necessárias. Verifique sua conexão.');
              }

              return _homeBody(context);
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

  _homeBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text("Get location"),
            onPressed: () {},
          ),
        ],
      ),
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
