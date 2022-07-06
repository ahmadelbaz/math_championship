import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/providers/points_provider.dart';
import 'package:math_championship/providers/settings_provider.dart';
import 'package:math_championship/widgets/custom_alert_dialog.dart';
import 'package:math_championship/widgets/custom_color_stack.dart';

import '../constants.dart';
import '../database/database.dart';
import '../screens/start_screen.dart';

class StoreProvider extends ChangeNotifier {
  final List<List<Color>> _themesForSale = [
    [const Color(0xffB10000), Colors.white, Colors.yellow, Colors.black],
    [const Color(0xff8200B6), Colors.white, Colors.yellow, Colors.black],
    [const Color(0xff13AF00), Colors.white, Colors.cyan, Colors.black],
  ];
  UnmodifiableListView get themesForSale =>
      UnmodifiableListView(_themesForSale);
  MyDatabase myDatabase = MyDatabase();

  onThemeClick(BuildContext context, int index) {
    final _pointsProvider = context.read(pointsChangeNotifierProvider);
    final _settingsProvider = context.read(settingsChangeNotifierProvider);

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
                style: TextStyle(color: _settingsProvider.currentTheme[0])),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await unlockTheme(
                  _themesForSale[index],
                  _pointsProvider.getPoints().mathCoins,
                  _pointsProvider,
                  _settingsProvider);
            },
            child: Text('Unlock',
                style: TextStyle(color: _settingsProvider.currentTheme[0])),
          ),
        ]);
  }

  unlockTheme(List<Color> colors, int currentCoins,
      PointsProvider pointsProvider, SettingsProvider settingsProvider) async {
    settingsProvider.addNewTheme(colors);

    int newCoins = currentCoins - themePrice;
    pointsProvider.updateCoins(newCoins);
    await myDatabase.mathDatabase();
    notifyListeners();
  }
}
