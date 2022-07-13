import '../models/achievement.dart';
import '../models/database_model.dart';
import '../models/mode_model.dart';
import '../models/point_model.dart';
import '../models/user_model.dart';

// we will create all modes and add it here
// first mode 'Solve'
DatabaseModel solveMode = Mode(
  id: '100',
  name: 'Solve',
  highScore: 0,
  price: 0,
  locked: 0,
  highScoreDateTime: DateTime.now(),
);

DatabaseModel randomSign = Mode(
  id: '101',
  name: 'Random Sign',
  highScore: 0,
  price: 20,
  locked: 1,
  highScoreDateTime: DateTime.now(),
);
// third mode 'Time is everything'
DatabaseModel timeIsEveyThing = Mode(
  id: '102',
  name: 'Time is eveything',
  highScore: 0,
  price: 50,
  locked: 1,
  highScoreDateTime: DateTime.now(),
);
// Fourth mode 'Double Value'
DatabaseModel doubleValue = Mode(
  id: '103',
  name: 'Double Value',
  highScore: 0,
  price: 50,
  locked: 1,
  highScoreDateTime: DateTime.now(),
);
// Fifth mode 'Square Root'
DatabaseModel sqrRoot = Mode(
  id: '104',
  name: 'Square Root',
  highScore: 0,
  price: 50,
  locked: 1,
  highScoreDateTime: DateTime.now(),
);
// add initial values for mathPoints and mathCoins
DatabaseModel pointsAndCoins = Point(id: '321', mathPoints: 0, mathCoins: 500);
// add initial values for User data
DatabaseModel userData =
    User(id: '1000', name: 'guest', mathPoints: 0, mathCoins: 0);

List<Achievement> allAchievements = [
  Achievement(id: '500', task: 'Create profile', price: 5, hasDone: false),
  Achievement(id: '501', task: 'Change Theme', price: 5, hasDone: false),
  Achievement(id: '502', task: 'Buy new Theme', price: 5, hasDone: false),
  Achievement(id: '503', task: 'Create new Theme', price: 5, hasDone: false),
  Achievement(id: '504', task: 'Unlock new mode', price: 5, hasDone: false),
  Achievement(
      id: '505',
      task: 'Score 10 Math Points in one game',
      price: 5,
      hasDone: false),
  Achievement(
      id: '506',
      task: 'Score 50 Math Points in one game',
      price: 10,
      hasDone: false),
  Achievement(
      id: '507', task: 'Break your high score', price: 20, hasDone: false),
  Achievement(id: '508', task: 'Win one game', price: 50, hasDone: false),
];
