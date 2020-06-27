import 'file:///C:/Users/Chan/Desktop/covid-nearby/lib/components/card.dart';
import 'package:covidnearby/screens/common.dart';
import 'package:flutter/material.dart';
import 'package:covidnearby/screens/home.dart';

import 'screens/home.dart';
import 'screens/home.dart';
import 'screens/home.dart';
import 'screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CommonScreen(
      cidade_confirmados: "115.468 (+461)",
      cidade_fatais: "864 (+69)",
      cidade_mortalidade: "5,93%",
      estado_confirmados: "31.423 (+1444)",
      estado_fatais: "4124 (+545)",
      estado_mortalidade: "3,32%"
      ),
    );
  }
}
