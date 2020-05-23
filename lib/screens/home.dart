import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  Future<int> _initializeLocation() async {
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: FutureBuilder(
        future: _initializeLocation(),
        builder: (context, snapshot){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_currentPosition != null) Text(_currentAddress),
                FlatButton(
                  child: Text("Get location"),
                  onPressed: () {
                    _getCurrentLocation();
                    print(_currentPosition);
                    print(_currentAddress);
                  },
                ),
              ],
            ),
          );
        }
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _homeFavoriteFAB(context),
          SizedBox(
            height: 10,
          ),
          _homeSearchFAB(context),
      ]),
      bottomNavigationBar: _homeBNB(context),
    );
  }

  _homeSearchFAB(context) {
    return FloatingActionButton(
      onPressed: (){},
      child: Icon(Icons.search),
    );
  }

  _homeBNB(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text("Favoritos"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text("Pesquisar"),
        )
      ]
    );
  }

  _homeFavoriteFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){},
      child: Icon(Icons.favorite),
    );
  }


  _getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

//      // País: print(place.country);
//      // Estado: print(place.administrativeArea);
//      // Cidade: print(place.subAdministrativeArea);

      setState(() {
        _currentAddress =
        "${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}