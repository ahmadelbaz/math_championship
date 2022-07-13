import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/providers/points_provider.dart';
import 'package:math_championship/providers/settings_provider.dart';
import 'package:math_championship/widgets/custom_alert_dialog.dart';
import 'package:math_championship/widgets/custom_color_stack.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';

import '../constants.dart';
import '../database/database.dart';

class StoreProvider extends ChangeNotifier {
  final List<List<Color>> _themesForSale = [
    [const Color(0xffB10000), Colors.white, Colors.yellow, Colors.black],
    [const Color(0xff8200B6), Colors.white, Colors.yellow, Colors.black],
    [const Color(0xff016E35), Colors.white, Colors.cyan, Colors.black],
    [const Color(0xffC90078), Colors.white, Colors.cyan, Colors.black],
  ];
  UnmodifiableListView get themesForSale =>
      UnmodifiableListView(_themesForSale);
  MyDatabase myDatabase = MyDatabase();

  onThemeClick(BuildContext context, int index) {
    final pointsProvider = context.read(pointsChangeNotifierProvider);
    final settingsProvider = context.read(settingsChangeNotifierProvider);

    customAlertDialog(
        CustomColorStack(_themesForSale[index]),
        Text(
          'Do you want to unlock this theme ?\nIt will cost you \'$themePrice Math Coins\'',
          style: Theme.of(context).textTheme.headline3,
        ),
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
              context
                  .read(achievementsChangeNotifierProvider)
                  .checkAchievement(2, pointsProvider);
              await unlockTheme(context, _themesForSale[index], pointsProvider,
                  settingsProvider);
            },
            child: Text('Unlock',
                style: TextStyle(color: settingsProvider.currentTheme[0])),
          ),
        ]);
  }

  unlockTheme(BuildContext context, List<Color> colors,
      PointsProvider pointsProvider, SettingsProvider settingsProvider) async {
    int currentCoins = pointsProvider.getPoints().mathCoins;
    if (pointsProvider.getPoints().mathCoins < themePrice) {
      customSnackBar(
          'You don\'t have enough Math Coins to unlock this theme, collect some Math Coins and try again!');
    } else {
      settingsProvider.addNewTheme(colors,
          context.read(achievementsChangeNotifierProvider), pointsProvider);
      int newCoins = currentCoins - themePrice;
      // await myDatabase.mathDatabase();
      pointsProvider.updateCoins(newCoins);
    }
    notifyListeners();
  }
}
