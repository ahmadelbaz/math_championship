import 'package:math_championship/models/database_model.dart';


// Model for Math Points and Math Coins
class Point implements DatabaseModel {
  String id = '';
  int mathPoints = 0;
  int mathCoins = 0;

  Point({required this.id, required this.mathPoints, required this.mathCoins});

  // Handle the data that is coming from db
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

  // Handle the data before storing it in db
  @override
  Map<String, dynamic>? toMap() {
    return {
      'id': id,
      'mathpoints': mathPoints,
      'mathcoins': mathCoins,
    };
  }
}
