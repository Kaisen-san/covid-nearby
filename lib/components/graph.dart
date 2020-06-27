import 'package:covidnearby/models/brazil_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CovidGraph extends StatelessWidget {
  //final List<charts.Series> seriesList;
  final bool animate;

  final BrazilData brazilData;

  //CovidGraph(this.seriesList, {this.animate});
  CovidGraph(this.brazilData, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
//  factory CovidGraph.withSampleData() {
//    return new CovidGraph(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }


  @override
  Widget build(BuildContext context) {
    final confirmedData = [
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[0].date), brazilData.timeline[0].newConfirmed),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[1].date), brazilData.timeline[1].newConfirmed),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[2].date), brazilData.timeline[2].newConfirmed),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[3].date), brazilData.timeline[3].newConfirmed),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[4].date), brazilData.timeline[4].newConfirmed),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[5].date), brazilData.timeline[5].newConfirmed),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[6].date), brazilData.timeline[6].newConfirmed),
    ];

    final recoveredData = [
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[0].date), brazilData.timeline[0].newRecovered),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[1].date), brazilData.timeline[1].newRecovered),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[2].date), brazilData.timeline[2].newRecovered),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[3].date), brazilData.timeline[3].newRecovered),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[4].date), brazilData.timeline[4].newRecovered),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[5].date), brazilData.timeline[5].newRecovered),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[6].date), brazilData.timeline[6].newRecovered),
    ];

    final deathData = [
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[0].date), brazilData.timeline[0].newDeaths),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[1].date), brazilData.timeline[1].newDeaths),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[2].date), brazilData.timeline[2].newDeaths),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[3].date), brazilData.timeline[3].newDeaths),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[4].date), brazilData.timeline[4].newDeaths),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[5].date), brazilData.timeline[5].newDeaths),
      new TimeSeriesValues(DateTime.parse(brazilData.timeline[6].date), brazilData.timeline[6].newDeaths),
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
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
//  static List<charts.Series<TimeSeriesValues, DateTime>> _createSampleData() {
//    final data = [
//      new TimeSeriesValues(new DateTime(2017, 9, 19), 5),
//      new TimeSeriesValues(new DateTime(2017, 9, 26), 25),
//      new TimeSeriesValues(new DateTime(2017, 10, 3), 100),
//      new TimeSeriesValues(new DateTime(2017, 10, 10), 75),
//    ];
//
//    return [
//      new charts.Series<TimeSeriesValues, DateTime>(
//        id: 'Sales',
//        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//        domainFn: (TimeSeriesValues sales, _) => sales.time,
//        measureFn: (TimeSeriesValues sales, _) => sales.sales,
//        data: data,
//      )
//    ];
//  }
}

/// Sample time series data type.
class TimeSeriesValues {
  final DateTime time;
  final int value;

  TimeSeriesValues(this.time, this.value);
}