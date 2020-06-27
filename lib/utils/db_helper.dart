import 'dart:async';
import 'dart:io' as io;

import 'package:covidnearby/models/covid_favorites.dart';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE favorites(id INTEGER PRIMARY KEY,state TEXT,province TEXT)",
    );
  }

  Future<int> saveData(covid_Favorites user) async {
    var dbClient = await db;
    int res = await dbClient.insert("favorites", user.toMap());
    return res;
  }

  Future<List<covid_Favorites>> getUserModelData() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT * FROM favorites";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<covid_Favorites> list = result.map((item) {
      return covid_Favorites.fromMap(item);
    }).toList();

    print(result);
    return list;
  }
  Future <int> dbLength() async{
    var dbClient = await db;
    int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM favorites'));
    return count;
  }
  deleteClient(int id) async {
    var dbClient = await db;
    dbClient.delete("favorites", where: "id = ?", whereArgs: [id]);
    print("deletando" + id.toString());
  }
Future<int> addFavorite(String State, String Province){
  covid_Favorites fav1 = covid_Favorites(
    State,
    Province,

  );
  return saveData(fav1);

  }
}

