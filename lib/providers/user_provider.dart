import 'package:flutter/cupertino.dart';
import 'package:math_championship/database/database.dart';
import 'package:math_championship/models/user_model.dart';

import 'achievement_provider.dart';
import 'points_provider.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(id: '', name: '');

  MyDatabase myDatabase = MyDatabase();

  User getUser() {
    return _user;
  }

  void updateUserName(AchievementProvider achievementProvider, String name,
      PointsProvider pointsProvider) async {
    _user = User(
      id: _user.id,
      name: name,
    );
    await myDatabase.mathDatabase();
    await myDatabase.update(_user);
    // achievement : Create profile
    achievementProvider.checkAchievement(0, pointsProvider);
    notifyListeners();
  }

  Future<void> getUserData() async {
    await myDatabase.mathDatabase();
    _user =
        await myDatabase.getAllPointsOrUser('user', 'math_database') as User;
    notifyListeners();
  }
}
