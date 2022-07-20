import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/models/achievement.dart';
import 'package:math_championship/widgets/custom_alert_dialog.dart';

import '../database/database.dart';
import '../main.dart';
import 'points_provider.dart';

class AchievementProvider extends ChangeNotifier {
  List<Achievement> _achievements = [];
  List<Achievement> get achievements => _achievements;

  MyDatabase myDatabase = MyDatabase();

  Future<void> getAllAchievements() async {
    await myDatabase.mathDatabase();
    _achievements = await myDatabase.getAll('achievements', 'math_database')
        as List<Achievement>;
    notifyListeners();
  }

  checkAchievement(int index, PointsProvider pointsProvider) async {
    BuildContext? context = navigatorKey.currentContext;
    // Achievement newAchievemenet =
    //     _achievements.firstWhere((element) => element.id == id);
    // int index = _achievements.indexOf(newAchievemenet);
    if (!_achievements[index].hasDone) {
      int currentCoins = pointsProvider.getPoints().mathCoins;
      _achievements[index].hasDone = true;
      currentCoins += _achievements[index].price;
      playScoreBoardSound(
          context!.read(settingsChangeNotifierProvider).sounds[3]);
      customAlertDialog(
          const FittedBox(child: Text('🎉Achievement Unlocked!🎉')),
          Text(
              '${_achievements[index].task}.\n\n${_achievements[index].price} Math Coins added',
              style: Theme.of(context).textTheme.headline3),
          [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Got it',
                  style: TextStyle(
                      color: context
                          .read(settingsChangeNotifierProvider)
                          .currentTheme[0])),
            ),
          ]);
      await myDatabase.mathDatabase();
      pointsProvider.updateCoins(currentCoins);
      await myDatabase.update(_achievements[index]);
      // customSnackBar(
      //     'Achievement Unlocked : ${_achievements[index].task}, ${_achievements[index].price} Math Coins added');
      notifyListeners();
    }
  }
}
