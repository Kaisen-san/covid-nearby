import 'dart:convert';

import 'package:covidnearby/models/br_state.dart';
import 'package:covidnearby/models/country_data.dart';
import 'package:covidnearby/models/city_data.dart';
import 'package:covidnearby/models/state_data.dart';
import 'package:covidnearby/utils/data_requester.dart';
import 'package:covidnearby/screens/favorites.dart';
import 'package:covidnearby/screens/home.dart';
import 'package:covidnearby/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<BRState> states;
  CityData cityData;
  StateData stateData;
  CountryData countryData;
  bool _isDataLoaded = false;
  int _selectedTab = 0;

  Future<bool> _loadData() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    try {
      String statesRawData = await DefaultAssetBundle.of(context).loadString('assets/data/br_states.json');
      List<dynamic> statesParsedData = jsonDecode(statesRawData);
      states = statesParsedData.map((json) => BRState.fromJson(json)).toList();

      Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      List<Placemark> locations = await geolocator.placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark userLocation = locations[0];

      BRState state = states.firstWhere((state) => state.name == userLocation.administrativeArea);
      String city = userLocation.subAdministrativeArea;
      String countryAbbr = userLocation.isoCountryCode;

      DataRequester dataRequester = DataRequester();
      cityData = await dataRequester.getCityCases(state.abbreviation, city);
      stateData = await dataRequester.getStateCases(state.abbreviation);
      countryData = await dataRequester.getCountryCases(countryAbbr);
    } catch (error) {
      print(error);
    }

    return Future.value(true);
  }

  @override
  void initState() {
    _loadData().then((result) => setState(() => _isDataLoaded = result));
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDataLoaded) {
      return _buildScreen(
        title: 'Visão Geral',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 8.0,),
              Text('Carregando...'),
            ],
          )
        )
      );
    }

    if (states == null || cityData == null || stateData == null) {
      return _buildScreen(
        title: 'Visão Geral',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Não foi possível encontrar sua localização.'),
                  SizedBox(height: 8.0,),
                  Text('Tente reiniciar o aplicativo.'),
                ],
              ),
            ],
          )
        )
      );
    }

    switch (_selectedTab) {
      case 0:
        return _buildScreen(
          title: 'Visão Geral',
          body: HomeScreen(
            cityData: cityData,
            stateData: stateData,
            countryData: countryData,
          ),
        );
        break;
      case 1:
        return _buildScreen(
          title: 'Favoritos',
          body: FavoritesScreen(),
        );
        break;
      case 2:
        return _buildScreen(
          title: 'Buscar Cidades',
          body: SearchScreen(states: states,),
        );
        break;
    }

    return _buildScreen(
      title: 'Visão Geral',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Um erro desconhecido ocorreu.'),
                SizedBox(height: 8.0,),
                Text('Tente reiniciar o aplicativo.'),
              ],
            ),
          ],
        )
      ),
    );
  }

  _buildScreen({ title, body }) {
    return MaterialApp(
      title: 'COVID Nearby',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(title),),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() => _selectedTab = index);
          },
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
          ],
        ),
      )
    );
  }
}
