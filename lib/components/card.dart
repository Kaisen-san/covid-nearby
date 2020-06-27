import 'package:flutter/material.dart';

class CardCovid extends StatefulWidget {
  final String confirmados;
  final String fatais;
  final String mortalidade;
  final String titulo;

  CardCovid({Key key, this.confirmados, this.fatais, this.mortalidade, this.titulo}) : super(key: key);

  @override
  _CardCovidState createState() => _CardCovidState(confirmados, fatais, mortalidade, titulo);
}

class _CardCovidState extends State<CardCovid> {
  final String confirmados;
  final String fatais;
  final String mortalidade;
  final String titulo;

  _CardCovidState(this.confirmados, this.fatais, this.mortalidade, this.titulo);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 0.1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text("Confirmados"),
              trailing: Text(confirmados),
            ),
            ListTile(
              leading: Icon(Icons.clear),
              title: Text("Fatais"),
              trailing: Text(fatais),
            ),
            ListTile(
              leading: Icon(Icons.priority_high),
              title: Text("Mortalidade"),
              trailing: Text(mortalidade),
            )
          ],
        ),
      ),
    );
  }
}
