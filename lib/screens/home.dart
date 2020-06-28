import 'package:covidnearby/components/covid_info.dart';
import 'package:covidnearby/components/graph.dart';
import 'package:covidnearby/components/graph_label.dart';
import 'package:covidnearby/models/country_data.dart';
import 'package:covidnearby/models/city_data.dart';
import 'package:covidnearby/models/state_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final CityData cityData;
  final StateData stateData;
  final CountryData countryData;

  HomeScreen({ Key key, this.cityData, this.stateData, this.countryData }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 16,),
          Center(
            child: Text("Casos no Brasil",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ),
          SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CovidGraph(countryData),
            ),
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
                      GraphLabel("Confirmados", Colors.blue),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      GraphLabel("Recuperados", Colors.green),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      GraphLabel("Mortes", Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CovidInfo(
              place: /*countryData.name*/ 'Brasil',
              confirmed: countryData.latestData.confirmed,
              recovered: countryData.latestData.recovered,
              deaths: countryData.latestData.deaths,
              deathRatePercent: countryData.latestData.calculated.deathRate,
              newConfirmed: countryData.timeline[0].newConfirmed,
              newRecovered: countryData.timeline[0].newRecovered,
              newDeaths: countryData.timeline[0].newDeaths,
            ),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CovidInfo(
              place: stateData.stateAbbreviation,
              confirmed: stateData.lastAvailableConfirmed,
              deaths: stateData.lastAvailableDeaths,
              deathRatePercent: stateData.lastAvailableDeathRate * 100,
              newConfirmed: stateData.newConfirmed,
              newDeaths: stateData.newDeaths,
            ),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CovidInfo(
              place: cityData.city,
              confirmed: cityData.lastAvailableConfirmed,
              deaths: cityData.lastAvailableDeaths,
              deathRatePercent: cityData.lastAvailableDeathRate * 100,
              newConfirmed: cityData.newConfirmed,
              newDeaths: cityData.newDeaths,
            ),
          ),
          SizedBox(height: 16,),
        ],
      ),
    );
  }
}
