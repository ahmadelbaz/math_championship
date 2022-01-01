import 'package:math_championship/models/database_model.dart';

class User implements DatabaseModel {
  String id = '';
  String name = '';
  int mathPoints = 0;
  int mathCoins = 0;

  User({
    required this.id,
    required this.name,
    required this.mathPoints,
    required this.mathCoins,
  });

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
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
    return 'user';
  }

  @override
  Map<String, dynamic>? toMap() {
    return {
      'id': id,
      'name': name,
      'mathpoints': mathPoints,
      'mathcoins': mathCoins,
    };
  }
}
