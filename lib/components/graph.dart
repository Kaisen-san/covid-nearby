import 'package:covidnearby/models/country_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CovidGraph extends StatelessWidget {
  final bool animate;
  final CountryData countryData;

  CovidGraph(this.countryData, { this.animate });

  @override
  Widget build(BuildContext context) {
    final confirmedData = [
      new TimeSeriesValues(DateTime.parse(countryData.timeline[0].date), countryData.timeline[0].newConfirmed),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[1].date), countryData.timeline[1].newConfirmed),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[2].date), countryData.timeline[2].newConfirmed),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[3].date), countryData.timeline[3].newConfirmed),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[4].date), countryData.timeline[4].newConfirmed),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[5].date), countryData.timeline[5].newConfirmed),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[6].date), countryData.timeline[6].newConfirmed),
    ];

    final recoveredData = [
      new TimeSeriesValues(DateTime.parse(countryData.timeline[0].date), countryData.timeline[0].newRecovered),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[1].date), countryData.timeline[1].newRecovered),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[2].date), countryData.timeline[2].newRecovered),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[3].date), countryData.timeline[3].newRecovered),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[4].date), countryData.timeline[4].newRecovered),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[5].date), countryData.timeline[5].newRecovered),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[6].date), countryData.timeline[6].newRecovered),
    ];

    final deathData = [
      new TimeSeriesValues(DateTime.parse(countryData.timeline[0].date), countryData.timeline[0].newDeaths),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[1].date), countryData.timeline[1].newDeaths),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[2].date), countryData.timeline[2].newDeaths),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[3].date), countryData.timeline[3].newDeaths),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[4].date), countryData.timeline[4].newDeaths),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[5].date), countryData.timeline[5].newDeaths),
      new TimeSeriesValues(DateTime.parse(countryData.timeline[6].date), countryData.timeline[6].newDeaths),
    ];

    List<charts.Series<TimeSeriesValues, DateTime>> confirmedSeries = [
      new charts.Series<TimeSeriesValues, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesValues values, _) => values.time,
        measureFn: (TimeSeriesValues values, _) => values.value,
        data: confirmedData,
      ),
      new charts.Series<TimeSeriesValues, DateTime>(
        id: 'Recovered',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesValues values, _) => values.time,
        measureFn: (TimeSeriesValues values, _) => values.value,
        data: recoveredData,
      ),
      new charts.Series<TimeSeriesValues, DateTime>(
        id: 'Deaths',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesValues values, _) => values.time,
        measureFn: (TimeSeriesValues values, _) => values.value,
        data: deathData,
      ),
    ];

    return new charts.TimeSeriesChart(
      confirmedSeries,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

class TimeSeriesValues {
  final DateTime time;
  final int value;

  TimeSeriesValues(this.time, this.value);
}
