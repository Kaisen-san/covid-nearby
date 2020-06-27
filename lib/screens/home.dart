import 'dart:convert';
import 'package:covidnearby/models/covid_data.dart';
import 'package:covidnearby/models/br_state.dart';
import 'package:covidnearby/models/covid_favorites.dart';
import 'package:covidnearby/models/covid_request.dart';
import 'package:covidnearby/screens/common.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:covidnearby/utils/db_helper.dart';


int _currentIndex = 0;

class HomeScreen extends StatelessWidget {
  DatabaseHelper db = DatabaseHelper();
  Future<Map<String, dynamic>> _initApp(BuildContext context) async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
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

    return null;
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
              print("ok");
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
              print("OK");
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text("OK"),
                    ],
                  )
              );

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
     // bottomNavigationBar: _homeBNB(context),
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
          RaisedButton(
            child: Text('Open route'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommonScreen(
                cidade_confirmados: "115.468 (+461)",
                cidade_fatais: "864 (+69)",
                cidade_mortalidade: "5,93%",
                estado_confirmados: "31.423 (+1444)",
                estado_fatais: "4124 (+545)",
                estado_mortalidade: "3,32%"
                )),
              );
            },
          )
        ],
      ),
    );
  }

  _homeFavoriteFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //String State =
        //Straing Province =
        //db.addFavorite(State, Province);
      },
      child: Icon(Icons.favorite),
    );
  }
}
