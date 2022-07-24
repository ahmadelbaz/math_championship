import 'package:flutter/cupertino.dart';
import 'package:math_championship/models/achievement.dart';
import 'package:math_championship/models/database_model.dart';
import 'package:math_championship/models/mode_model.dart';
import 'package:math_championship/models/point_model.dart';
import 'package:math_championship/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_consts.dart';

// final dbProvider = ChangeNotifierProvider<MyDatabase>(
//   (ref) {
//     return MyDatabase();
//   },
// );

class MyDatabase extends ChangeNotifier {
  Future<Database> mathDatabase() async {
    // Method for version 1 of the database
    void createTablesV1(Batch batch) {
      // Creating tables if not found
      batch.execute('DROP TABLE IF EXISTS modes');
      batch.execute('''CREATE TABLE modes (
    id TEXT PRIMARY KEY, name TEXT, highscore INTEGER, price INEGER, locked INEGER, datetime INTEGER
)''');
      batch.execute('DROP TABLE IF EXISTS points');
      batch.execute('''CREATE TABLE points (
    id TEXT PRIMARY KEY, mathpoints INTEGER, mathcoins INTEGER
)''');
      batch.execute('DROP TABLE IF EXISTS powerups');
      batch.execute('''CREATE TABLE powerups (
    id TEXT PRIMARY KEY, name TEXT, count INTEGER, price INTEGER
)''');
      batch.execute('DROP TABLE IF EXISTS user');
      batch.execute('''CREATE TABLE user (
    id TEXT PRIMARY KEY, name TEXT, mathpoints INTEGER, mathcoins INTEGER
)''');
      batch.execute('DROP TABLE IF EXISTS achievements');
      batch.execute('''CREATE TABLE achievements (
    id TEXT PRIMARY KEY, task TEXT, price INTEGER, hasDone INTEGER
)''');
// Adding default data to tables in DB
      for (DatabaseModel n in allModes) {
        batch.insert('modes', n.toMap()!,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      batch.insert('points', pointsAndCoins.toMap()!,
          conflictAlgorithm: ConflictAlgorithm.replace);
      batch.insert('user', userData.toMap()!,
          conflictAlgorithm: ConflictAlgorithm.replace);
      for (Achievement n in allAchievements) {
        batch.insert('achievements', n.toMap()!,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    // First version of the database
    return openDatabase(
      join(await getDatabasesPath(), 'math_database.db'),
      version: 1,
      onCreate: (db, version) async {
        var batch = db.batch();
        createTablesV1(batch);
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  Future<Database> getDatabase(DatabaseModel model) async {
    return await getDatabaseByName('${model.database()}');
  }

  Future<Database> getDatabaseByName(String dbName) {
    switch (dbName) {
      case 'math_database':
        return mathDatabase();
      default:
        return mathDatabase();
    }
  }

  // Insert in DB method using table name & the data itself
  Future<void> insert(DatabaseModel model) async {
    final db = await getDatabase(model);
    db.insert(
      model.table()!,
      model.toMap()!,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update data in DB method using table name, the new data & id
  Future<void> update(DatabaseModel model) async {
    final db = await getDatabase(model);
    db.update(
      model.table()!,
      model.toMap()!,
      where: 'id = ?',
      whereArgs: [model.getId()],
    );
    notifyListeners();
  }

  // Delete data from DB method using table name & id
  Future<void> delete(DatabaseModel model) async {
    final db = await getDatabase(model);
    db.delete(
      model.table()!,
      where: 'id = ?',
      whereArgs: [model.getId()],
    );
  }

  // Method to get data from database to use it in the app
  Future<List<DatabaseModel>> getAll(String table, String dbName) async {
    final db = await getDatabaseByName(dbName);
    final List<Map<String, dynamic>> maps = await db.query(table);
    List<Mode> modesModel = [];
    List<Mode> powerUpsModel = [];
    List<Achievement> ahievements = [];
    for (var item in maps) {
      switch (table) {
        case 'modes':
          modesModel.add(Mode.fromMap(item));
          break;
        case 'achievements':
          ahievements.add(Achievement.fromMap(item));
      }
    }
    return table == 'modes'
        ? modesModel
        : table == 'achievements'
            ? ahievements
            : powerUpsModel;
  }

  // Method to get points & user data from database to use it in the app
  Future<DatabaseModel> getAllPointsOrUser(String table, String dbName) async {
    final db = await getDatabaseByName(dbName);
    final List<Map<String, dynamic>> maps = await db.query(table);
    Point points = Point(id: '', mathPoints: 0, mathCoins: 0);
    User user = User(id: '', name: '');
    for (var item in maps) {
      switch (table) {
        case 'points':
          points = Point.fromMap(item);
          break;
        case 'user':
          user = User.fromMap(item);
          break;
      }
    }
    return table == 'points' ? points : user;
  }
}
