import 'database_model.dart';

class Mode implements DatabaseModel {
  String id = '';
  String name = '';
  int highScore = 0;
  DateTime highScoreDateTime = DateTime.now();

  Mode(
      {required this.id,
      required this.name,
      required this.highScore,
      required this.highScoreDateTime});

  Mode.fromMap(Map<String, dynamic> map) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(map['datetime']);
    id = map['id'];
    name = map['name'];
    highScore = map['highscore'];
    highScoreDateTime = dateTime;
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
    return 'modes';
  }

  @override
  Map<String, dynamic>? toMap() {
    int storedDateTime = highScoreDateTime.millisecondsSinceEpoch;
    return {
      'id': id,
      'name': name,
      'highscore': highScore,
      'dateTime': storedDateTime
    };
  }
}
