import 'package:covidnearby/components/covid_info.dart';
import 'package:covidnearby/models/city_data.dart';
import 'package:covidnearby/models/favorite.dart';
import 'package:covidnearby/models/state_data.dart';
import 'package:covidnearby/utils/data_requester.dart';
import 'package:covidnearby/utils/db_wrapper.dart';
import 'package:flutter/material.dart';

class CommonScreen extends StatefulWidget {
  final String stateAbbr;
  final String city;

  CommonScreen({ Key key, this.stateAbbr, this.city }) : super(key: key);

  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  DBWrapper db = DBWrapper();
  CityData covidCountyData;
  StateData covidStateData;
  List<Favorite> favorites = List<Favorite>();
  bool skipDataLoading = false;

  Future _loadData(BuildContext context) async {
    if (skipDataLoading) return;

    try {
      DataRequester dataRequester = DataRequester();
      covidCountyData = await dataRequester.getCityCases(widget.stateAbbr, widget.city);
      covidStateData = await dataRequester.getStateCases(widget.stateAbbr);
      favorites = await db.getAll();
      skipDataLoading = true;
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    db.getAll().then((result) => setState(() => favorites = result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes'),),
      body: FutureBuilder(
        future: _loadData(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 8.0,),
                    Text('Carregando...'),
                  ],
                )
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (covidCountyData == null || covidStateData == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Não foi possível carregar os dados.'),
                          SizedBox(height: 8.0,),
                          Text('Verifique sua conexão.'),
                        ],
                      ),
                    ],
                  )
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    CovidInfo(
                      place: widget.stateAbbr,
                      confirmed: covidStateData.lastAvailableConfirmed,
                      deaths: covidStateData.lastAvailableDeaths,
                      deathRatePercent: covidStateData.lastAvailableDeathRate * 100,
                      newConfirmed: covidStateData.newConfirmed,
                      newDeaths: covidStateData.newDeaths,
                    ),
                    SizedBox(height: 16,),
                    CovidInfo(
                      place: widget.city,
                      confirmed: covidCountyData.lastAvailableConfirmed,
                      deaths: covidCountyData.lastAvailableDeaths,
                      deathRatePercent: covidCountyData.lastAvailableDeathRate * 100,
                      newConfirmed: covidCountyData.newConfirmed,
                      newDeaths: covidCountyData.newDeaths,
                    ),
                  ],
                )
              );
              break;
          }

          return Center(
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
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: favorites.any((favorite) => favorite.stateAbbr == widget.stateAbbr && favorite.city == widget.city)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
            onPressed: () {
              int index = favorites.indexWhere((favorite) => favorite.stateAbbr == widget.stateAbbr && favorite.city == widget.city);
              if (index != -1) {
                db.delete(favorites[index].id)
                  .then((value) => setState(() => favorites.removeAt(index)));
              } else {
                db.save(Favorite(stateAbbr: widget.stateAbbr, city: widget.city))
                  .then((result) => setState(() => favorites.add(Favorite(id: result, stateAbbr: widget.stateAbbr, city: widget.city))));
              }
            },
          ),
        ],
      ),
    );
  }
}
