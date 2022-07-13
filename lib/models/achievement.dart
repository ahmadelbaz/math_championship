// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'database_model.dart';

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

  Achievement.fromMap(Map<String, dynamic> map) {
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

  @override
  Map<String, dynamic>? toMap() {
    final newHasDone = hasDone ? 1 : 0;
    return {'id': id, 'task': task, 'price': price, 'hasDone': newHasDone};
  }
}
