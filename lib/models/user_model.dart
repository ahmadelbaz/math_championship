import 'package:math_championship/models/database_model.dart';

// Mode for user that has its id and name (maybe more data in the future)
class User implements DatabaseModel {
  String id = '';
  String name = '';

  User({
    required this.id,
    required this.name,
  });

  // Handle the data that is coming from db
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

  // Handle the data before storing it in db
  @override
  Map<String, dynamic>? toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
