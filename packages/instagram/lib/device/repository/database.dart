import 'package:instagram/device/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHandler {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();

    print(_db);
    return _db;
  }

  initDb() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "instagram1.db");
    var theDb = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    print(theDb);
    return theDb;
  }

  void _onUpgrade(Database db, int a, int version) async {}

  void _onCreate(Database db, int version) async {
    await db.execute(profileTable);
  }
}
