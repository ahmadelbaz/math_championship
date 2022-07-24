import 'package:math_championship/models/database_model.dart';

class User implements DatabaseModel {
  String id = '';
  String name = '';

  User({
    required this.id,
    required this.name,
  });

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
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
    };
  }
}
