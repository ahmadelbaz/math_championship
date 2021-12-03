import 'package:math_championship/models/database_model.dart';

class Point implements DatabaseModel {
  String id = '';
  int mathPoints = 0;
  int mathCoins = 0;

  Point({required this.id, required this.mathPoints, required this.mathCoins});

  Point.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    mathPoints = map['mathpoints'];
    mathCoins = map['mathcoins'];
  }

  @override
  String? database() {
    return 'math_database';
  }

  @override
  String? getId() {
    return id;
  }

  @override
  String? table() {
    return 'points';
  }

  @override
  Map<String, dynamic>? toMap() {
    return {'id': id, 'mathpoints': mathPoints, 'mathcoins': mathCoins};
  }
}
