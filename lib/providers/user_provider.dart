import 'package:flutter/cupertino.dart';
import 'package:math_championship/database/database.dart';
import 'package:math_championship/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(id: '', name: '', mathPoints: 0, mathCoins: 0);

  MyDatabase myDatabase = MyDatabase();

  User getUser() {
    return _user;
  }

  void updateUserID(String id) async {
    _user = User(
        id: id,
        name: _user.name,
        mathPoints: _user.mathPoints,
        mathCoins: _user.mathCoins);
    await myDatabase.mathDatabase();
    await myDatabase.update(_user);
    notifyListeners();
  }

  void updateUserName(String name) async {
    _user = User(
        id: _user.id,
        name: name,
        mathPoints: _user.mathPoints,
        mathCoins: _user.mathCoins);
    await myDatabase.mathDatabase();
    await myDatabase.update(_user);
    notifyListeners();
  }

  void updateUserMathPoints(int mathPoints) async {
    _user = User(
        id: _user.id,
        name: _user.name,
        mathPoints: _user.mathPoints + mathPoints,
        mathCoins: _user.mathCoins);
    await myDatabase.mathDatabase();
    await myDatabase.update(_user);
    notifyListeners();
  }

  void updateUserMathCoins(int mathCoins) async {
    _user = User(
        id: _user.id,
        name: _user.name,
        mathPoints: _user.mathPoints,
        mathCoins: _user.mathCoins + mathCoins);
    await myDatabase.mathDatabase();
    await myDatabase.update(_user);
    notifyListeners();
  }

  // void updatePoints(int score) async {
  //   int newPoints = score;
  //   int newCoins = (score / 5).floor();
  //   _points = Point(
  //       id: _points.id,
  //       mathPoints: _points.mathPoints + newPoints,
  //       mathCoins: _points.mathCoins + newCoins);
  //   await myDatabase.mathDatabase();
  //   await myDatabase.update(_points);
  //   notifyListeners();
  // }

  Future<void> getUserData() async {
    await myDatabase.mathDatabase();
    _user =
        await myDatabase.getAllPointsOrUser('user', 'math_database') as User;
    notifyListeners();
  }
}
