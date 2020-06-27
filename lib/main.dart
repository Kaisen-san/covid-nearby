import 'package:covidnearby/screens/favorites.dart';
import 'package:covidnearby/screens/favorites.dart';

import 'package:covidnearby/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:covidnearby/screens/home.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
      @override
      State<StatefulWidget> createState() {
        return MyAppState();
      }}class MyAppState extends State<MyApp> {
      int _selectedTab = 0;
      final _pageOptions = [
        HomeScreen(),
        Favorites2(),
        Search(),
      ];
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            //appBar: AppBar(
              //title: Text('Loopt In'),
          //),
            body: _pageOptions[_selectedTab],
            bottomNavigationBar: BottomNavigationBar(            currentIndex: _selectedTab,
              onTap: (int index) {
              setState(() {
                _selectedTab = index;
              });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                title: Text('Início'),
              ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  title: Text('Favoritos'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text('Busca'),
                ),
              ],
            ),
          ),
        );
  }
}









/*

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
<<<<<<< Updated upstream
*/
=======
*/
>>>>>>> Stashed changes
