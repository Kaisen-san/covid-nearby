import 'package:covidnearby/models/favorite.dart';
import 'package:covidnearby/screens/common.dart';
import 'package:covidnearby/utils/db_wrapper.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  _FavoritesScreen createState() => _FavoritesScreen();
}

class _FavoritesScreen extends State<FavoritesScreen> {
  DBWrapper db = DBWrapper();
  List<Favorite> favorites = List<Favorite>();
  
  Future _loadData(BuildContext context) async {
    try {
      favorites = await db.getAll();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (favorites == null) {
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

              if (favorites.length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Você não possui nenhum favorito...'),
                          SizedBox(height: 8.0,),
                          Text(':('),
                        ],
                      ),
                    ],
                  )
                );

              }

              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (content, index) {
                  return Card(
                    child: ListTile(
                      title: Text(favorites[index].city),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[600],
                        child: Text(favorites[index].stateAbbr,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          )
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => CommonScreen(
                              stateAbbr: favorites[index].stateAbbr,
                              city: favorites[index].city,
                            ),
                          ),
                        ).then((value) => setState(() {}));
                      },
                      onLongPress: () {
                        db.delete(favorites[index].id).then((value) => setState(() {}));
                      },
                    ),
                  );
                },
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
    );
  }
}
