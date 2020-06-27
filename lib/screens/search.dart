import 'dart:convert';

import 'package:covidnearby/main.dart';
import 'package:covidnearby/models/covid_data.dart';
import 'package:covidnearby/models/br_state.dart';
import 'package:covidnearby/models/covid_request.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
int _currentIndex = 0;
class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Busca"),
    ),
    );
  }
}