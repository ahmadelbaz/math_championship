import 'database_model.dart';

// Model for mode (like, solve, random sign etc)
class Mode implements DatabaseModel {
  String id = '';
  String name = '';
  int highScore = 0;
  int price = 0;
  int locked = 0;
  DateTime highScoreDateTime = DateTime.now();

  Mode(
      {required this.id,
      required this.name,
      required this.highScore,
      required this.price,
      required this.locked,
      required this.highScoreDateTime});

  // Handle the data that is coming from db
  Mode.fromMap(Map<String, dynamic> map) {
    // Convert int to DateTime (becauze we cant store DateTime type in sqlite)
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(map['datetime']);
    id = map['id'];
    name = map['name'];
    highScore = map['highscore'];
    price = map['price'];
    locked = map['locked'];
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

  // Handle the data before storing it in db
  @override
  Map<String, dynamic>? toMap() {
    // Convert DateTime to int
    int storedDateTime = highScoreDateTime.millisecondsSinceEpoch;
    return {
      'id': id,
      'name': name,
      'highscore': highScore,
      'price': price,
      'locked': locked,
      'dateTime': storedDateTime
    };
  }
}
