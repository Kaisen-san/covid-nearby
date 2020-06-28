import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CovidInfo extends StatelessWidget {
  final String place;
  final int confirmed;
  final int recovered;
  final int deaths;
  final double deathRatePercent;
  final int newConfirmed;
  final int newRecovered;
  final int newDeaths;

  CovidInfo({
    Key key,
    this.place,
    this.confirmed,
    this.recovered,
    this.deaths,
    this.deathRatePercent,
    this.newConfirmed,
    this.newRecovered,
    this.newDeaths
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(width: 0.1)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(place,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
            ListTile(
              leading: Icon(Icons.add, color: Colors.blue[800],),
              title: Text("Confirmados"),
              trailing: Text('${_BRNumberFormat(confirmed)}   (+${_BRNumberFormat(newConfirmed)})'),
            ),
            if(recovered != null && newRecovered != null)
              ListTile(
                leading: Icon(Icons.check, color: Colors.green[600],),
                title: Text("Recuperados"),
                trailing: Text('${_BRNumberFormat(recovered)}   (+${_BRNumberFormat(newRecovered)})'),
              ),
            ListTile(
              leading: Icon(Icons.clear, color: Colors.redAccent[700],),
              title: Text("Fatais"),
              trailing: Text('${_BRNumberFormat(deaths)}   (+${_BRNumberFormat(newDeaths)})'),
            ),
            ListTile(
              leading: Icon(Icons.priority_high, color: Colors.amberAccent[400],),
              title: Text("Mortalidade"),
              trailing: Text('${deathRatePercent.toStringAsFixed(2)}%'),
            )
          ],
        ),
      ),
    );
  }

  String _BRNumberFormat(int number) {
    return NumberFormat.decimalPattern('pt_BR').format(number);
  }
}
