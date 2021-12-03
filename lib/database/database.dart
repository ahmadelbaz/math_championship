import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:math_championship/models/database_model.dart';
import 'package:math_championship/models/mode_model.dart';
import 'package:math_championship/models/point_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbProvider = ChangeNotifierProvider<MyDatabase>((ref) {
  return MyDatabase();
});

class MyDatabase extends ChangeNotifier {
  Future<Database> mathDatabase() async {
    // we will create all modes and add it here
    // first mode 'Solve'
    DatabaseModel solveMode = Mode(
        id: '100',
        name: 'Solve',
        highScore: 0,
        highScoreDateTime: DateTime.now());
    // second mode 'Time is everything'
    DatabaseModel timeIsEveyThing = Mode(
        id: '101',
        name: 'Time is eveything',
        highScore: 0,
        highScoreDateTime: DateTime.now());
    // add initial values for mathPoints and mathCoins
    DatabaseModel pointsAndCoins =
        Point(id: '321', mathPoints: 0, mathCoins: 0);
    // DatabaseModel pu = PowerUps(id: '5', name: 'Revive', count: 4, price: 120);
    void _createTablesV1(Batch batch) {
      batch.execute('DROP TABLE IF EXISTS modes');
      batch.execute('''CREATE TABLE modes (
    id TEXT PRIMARY KEY, name TEXT, highscore INTEGER, datetime INTEGER
)''');
      batch.execute('DROP TABLE IF EXISTS points');
      batch.execute('''CREATE TABLE points (
    id TEXT PRIMARY KEY, mathpoints INTEGER, mathcoins INTEGER
)''');
      batch.execute('DROP TABLE IF EXISTS powerups');
      batch.execute('''CREATE TABLE powerups (
    id TEXT PRIMARY KEY, name TEXT, count INTEGER, price INTEGER
)''');
      batch.insert('modes', solveMode.toMap()!,
          conflictAlgorithm: ConflictAlgorithm.replace);
      batch.insert('modes', timeIsEveyThing.toMap()!,
          conflictAlgorithm: ConflictAlgorithm.replace);
      batch.insert('points', pointsAndCoins.toMap()!,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    // First version of the database
    return openDatabase(
      join(await getDatabasesPath(), 'math_database.db'),
      version: 1,
      onCreate: (db, version) async {
        var batch = db.batch();
        _createTablesV1(batch);
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  // try to use it
  Future<Database> getDatabase(DatabaseModel model) async {
    return await getDatabaseByName('${model.database()}');
  }

  Future<Database> getDatabaseByName(String dbName) {
    switch (dbName) {
      case 'math_database':
        return mathDatabase();
      default:
        return null!;
    }
  }

  Future<void> insert(DatabaseModel model) async {
    // final db = await dogDatabase();
    final db = await getDatabase(model);
    db.insert(
      model.table()!,
      model.toMap()!,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // db.close();
  }

  Future<void> update(DatabaseModel model) async {
    final db = await getDatabase(model);
    db.update(
      model.table()!,
      model.toMap()!,
      where: 'id = ?',
      whereArgs: [model.getId()],
    );
    notifyListeners();
    // db.close();
  }

  Future<void> delete(DatabaseModel model) async {
    final db = await getDatabase(model);
    db.delete(
      model.table()!,
      where: 'id = ?',
      whereArgs: [model.getId()],
    );
    // db.close();
  }

  Future<List<DatabaseModel>> getAll(String table, String dbName) async {
    final db = await getDatabaseByName(dbName);
    final List<Map<String, dynamic>> maps = await db.query(table);
    List<Mode> modesModel = [];
    List<Mode> powerUpsModel = [];
    for (var item in maps) {
      switch (table) {
        case 'modes':
          modesModel.add(Mode.fromMap(item));
          break;
      }
    }
    return table == 'modes' ? modesModel : powerUpsModel;
  }

  Future<DatabaseModel> getAllPoints(String table, String dbName) async {
    final db = await getDatabaseByName(dbName);
    final List<Map<String, dynamic>> maps = await db.query(table);
    Point points = Point(id: '', mathPoints: 0, mathCoins: 0);
    for (var item in maps) {
      switch (table) {
        case 'points':
          points = Point.fromMap(item);
          break;
      }
    }
    return points;
  }
}
