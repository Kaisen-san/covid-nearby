import 'package:covidnearby/models/favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBWrapper {
  DBWrapper._internal(); 

  static final DBWrapper _instance = DBWrapper._internal();

  factory DBWrapper() => _instance;

  static Database _db;

  Future<Database> get getDB async {
    if (_db == null) _db = await _initDb();
    return _db;
  }

  Future<Database>_initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'app.db');

    return await openDatabase(path,
      version: 1,
      onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE favorites('
        'id INTEGER PRIMARY KEY,'
        'state TEXT,'
        'city TEXT'
      ')',
    );
  }

  Future<int> save(Favorite favorite) async {
    Database db = await getDB;
    return await db.insert('favorites', favorite.toMap());
  }

  Future<List<Favorite>> getAll() async {
    Database db = await getDB;
    var result = await db.rawQuery('SELECT * FROM favorites');

    if (result.length == 0) return Future.value([]);
    return result.map((item) => Favorite.fromMap(item)).toList();
  }

  Future<int> delete(int id) async {
    Database db = await getDB;
    return db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
