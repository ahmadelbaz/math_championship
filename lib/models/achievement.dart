// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'database_model.dart';

// Model for achievement
class Achievement implements DatabaseModel {
  String id = '';
  String task = '';
  int price = 0;
  bool hasDone = false;
  Achievement({
    required this.id,
    required this.task,
    required this.price,
    required this.hasDone,
  });

  // Handle the data that is coming from db
  Achievement.fromMap(Map<String, dynamic> map) {
    // Convert int to bool (cuz sqlite doesn't have bool so we use int instead)
    final newHasDone = map['hasDone'] == 0 ? false : true;
    id = map['id'];
    task = map['task'];
    price = map['price'];
    hasDone = newHasDone;
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
    return 'achievements';
  }

  // Handle the data before storing it in db
  @override
  Map<String, dynamic>? toMap() {
    // Convert bool to int to store it in db
    final newHasDone = hasDone ? 1 : 0;
    return {'id': id, 'task': task, 'price': price, 'hasDone': newHasDone};
  }
}
