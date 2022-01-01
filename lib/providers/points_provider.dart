import 'package:flutter/cupertino.dart';
import 'package:math_championship/database/database.dart';
import 'package:math_championship/models/point_model.dart';

class PointsProvider extends ChangeNotifier {
  Point _points = Point(id: '', mathPoints: 0, mathCoins: 0);

  MyDatabase myDatabase = MyDatabase();

  Point getPoints() {
    return _points;
  }

  void updatePoints(int score) async {
    int newPoints = score;
    int newCoins = (score / 5).floor();
    _points = Point(
        id: _points.id,
        mathPoints: _points.mathPoints + newPoints,
        mathCoins: _points.mathCoins + newCoins);
    await myDatabase.mathDatabase();
    await myDatabase.update(_points);
    notifyListeners();
  }

  Future<void> getAllPoints() async {
    await myDatabase.mathDatabase();
    _points =
        await myDatabase.getAllPointsOrUser('points', 'math_database') as Point;
    notifyListeners();
  }
}
