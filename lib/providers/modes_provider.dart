import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/database/database.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/models/mode_model.dart';
import 'package:math_championship/providers/achievement_provider.dart';
import 'package:math_championship/providers/points_provider.dart';

import '../functions/start_mode_function.dart';
import '../widgets/custom_alert_dialog.dart';

class ModesProvider extends ChangeNotifier {
  List<Mode> _modes = [];

  MyDatabase myDatabase = MyDatabase();

  UnmodifiableListView get modes => UnmodifiableListView(_modes);

  Future<void> updateHighScore(int newHighScore, String id) async {
    Mode newMode = _modes.firstWhere((element) => element.id == id);
    int index = _modes.indexOf(newMode);
    _modes[index].highScore = newHighScore;
    _modes[index].highScoreDateTime = DateTime.now();
    await myDatabase.mathDatabase();
    await myDatabase.update(_modes[index]);
    notifyListeners();
  }

  // method called when we click on any mode on 'start screen'
  void onClickMode(BuildContext context, int index) async {
    final pointsProvider = context.read(pointsChangeNotifierProvider);
    final settingsProvider = context.read(settingsChangeNotifierProvider);
    if (_modes[index].locked == 1) {
      if (checkPrice(_modes[index].id, pointsProvider.getPoints().mathCoins)) {
        customAlertDialog(
          const FittedBox(child: Text('Unlock Mode')),
          Text(
              'Do you want to unlock \'${_modes[index].name}\' mode for \'${_modes[index].price} Math Coins\' ?',
              style: Theme.of(context).textTheme.headline3),
          [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: TextStyle(color: settingsProvider.currentTheme[0])),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                unlockMode(
                    _modes[index].id,
                    pointsProvider.getPoints().mathCoins,
                    pointsProvider,
                    context.read(achievementsChangeNotifierProvider));
              },
              child: Text('Unlock',
                  style: TextStyle(color: settingsProvider.currentTheme[0])),
            ),
          ],
        );
      } else {
        customAlertDialog(
            const FittedBox(child: Text('Not enough money!')),
            Text(
                'You don\'t have enough coins, you need \'${_modes[index].price} Math Coins\' to unlock this mode, keep going and try again later.',
                style: Theme.of(context).textTheme.headline3),
            [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Sure',
                      style:
                          TextStyle(color: settingsProvider.currentTheme[0])))
            ]);
      }
    } else {
      startMode(context.read, context, index);
    }

    // _modesProvider.modes[index].locked == 1
    //     ? _modesProvider.checkPrice(
    //         _modesProvider.modes[index].id,
    //         _pointsProvider.getPoints().mathCoins) ? _modesProvider.unlockMode(_modesProvider.modes[index].id,
    //         _pointsProvider.getPoints().mathCoins, _pointsProvider)
    //     : startMode(watch, context, index);
  }

  bool checkPrice(String id, int currentCoins) {
    Mode newMode = _modes.firstWhere((element) => element.id == id);
    int index = _modes.indexOf(newMode);
    if (_modes[index].price <= currentCoins) {
      return true;
    } else {
      return false;
    }
  }

  void unlockMode(String id, int currentCoins, PointsProvider pointsProvider,
      AchievementProvider achievementProvider) async {
    Mode newMode = _modes.firstWhere((element) => element.id == id);
    int index = _modes.indexOf(newMode);
    // if (_modes[index].price >= currentCoins) {
    _modes[index].locked = 0;
    int newCoins = currentCoins - _modes[index].price;
    pointsProvider.updateCoins(newCoins);
    await myDatabase.mathDatabase();
    await myDatabase.update(_modes[index]);
    // achievement : Unlock New mode
    achievementProvider.checkAchievement(6, pointsProvider);
    notifyListeners();
  }

  Future<void> getAllModes() async {
    await myDatabase.mathDatabase();
    _modes = await myDatabase.getAll('modes', 'math_database') as List<Mode>;
    notifyListeners();
  }
}
