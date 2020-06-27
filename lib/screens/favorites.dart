import 'package:covidnearby/models/covid_favorites.dart';
import 'package:covidnearby/utils/db_helper.dart';
import 'package:flutter/material.dart';


class Favorites2 extends StatefulWidget {
  FavoritesState2 createState() =>  FavoritesState2();
}

class FavoritesState2 extends State<Favorites2> {
  DatabaseHelper db = DatabaseHelper();
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favoritos'),
        ),
        body: FutureBuilder<List>(
          future: db.getUserModelData(),
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, int position) {

                final item = snapshot.data[(position) ];
                //get your item data here ...
                int id = snapshot.data[position].id;
                return Card(
                  child: ListTile(
                    onLongPress:  ()=>  delete_favorite(id),
                    //onTap:   abrir a página,
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(snapshot.data[position].State,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          )),
                    ),
                    title: Text(
                        snapshot.data[position].Province),
                  ),
                );
              },
            )
                : Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    }
  void delete_favorite(int id){
    db.deleteClient(id);
    setState(() {
    }
    );
  }
}




