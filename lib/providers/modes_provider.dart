import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:math_championship/database/database.dart';
import 'package:math_championship/models/mode_model.dart';
import 'package:math_championship/providers/points_provider.dart';

class ModesProvider extends ChangeNotifier {
  List<Mode> _modes = [];

  MyDatabase myDatabase = MyDatabase();

  UnmodifiableListView get modes => UnmodifiableListView(_modes);

  Future<void> updateHighScore(int newHighScore, String id) async {
    Mode newMode = _modes.firstWhere((element) => element.id == id);
    int index = _modes.indexOf(newMode);
    _modes[index].highScore = newHighScore;
    _modes[index].highScoreDateTime = DateTime.now();
    await myDatabase.mathDatabase();
    await myDatabase.update(_modes[index]);
    notifyListeners();
  }

  bool checkPrice(String id, int currentCoins) {
    Mode newMode = _modes.firstWhere((element) => element.id == id);
    int index = _modes.indexOf(newMode);
    if (_modes[index].price <= currentCoins) {
      return true;
    } else {
      return false;
    }
  }

  void unlockMode(
      String id, int currentCoins, PointsProvider pointsProvider) async {
    Mode newMode = _modes.firstWhere((element) => element.id == id);
    int index = _modes.indexOf(newMode);
    // if (_modes[index].price >= currentCoins) {
    _modes[index].locked = 0;
    int newCoins = currentCoins - _modes[index].price;
    pointsProvider.updateCoins(newCoins);
    await myDatabase.mathDatabase();
    await myDatabase.update(_modes[index]);
    notifyListeners();
  }

  Future<void> getAllModes() async {
    await myDatabase.mathDatabase();
    _modes = await myDatabase.getAll('modes', 'math_database') as List<Mode>;
    notifyListeners();
  }
}
