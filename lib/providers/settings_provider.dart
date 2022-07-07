import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/providers/points_provider.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database.dart';
import '../widgets/custom_alert_dialog.dart';
import '../widgets/custom_color_stack.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    _getCurrentTheme();
    _getAllThemes();
    _getSoundSettings();
    getAddingThemeValue();
  }

  MyDatabase myDatabase = MyDatabase();

  final List<bool> _sounds = [true, true, true, true, true, true, true];
  List<bool> get sounds => _sounds;

  final List<List<Color>> _userThemes = [];
  List<List<Color>> get userThemes => _userThemes;

  final List<List<Color>> _themes = [];
  List<List<Color>> get themes => _themes;

  final List<List<Color>> _defaultThemes = [
    [
      Colors.cyan.shade700,
      const Color.fromARGB(255, 3, 23, 61),
      const Color(0xFFECEFF1),
      const Color(0xFFFFDE03)
    ],
    [
      const Color(0xFFFFDE03),
      Colors.black,
      const Color(0xFF0336FF),
      Colors.pink
    ],
    [
      Colors.black,
      Colors.cyan,
      Colors.pink,
      Colors.yellow,
    ],
  ];
  List<List<Color>> get defaultThemes => _defaultThemes;

  final List<Color> _currentTheme = [
    const Color(0xFFFFDE03),
    Colors.black,
    const Color(0xFF0336FF),
    Colors.pink
  ];
  List<Color> get currentTheme => _currentTheme;

  bool _canAddThemes = false;
  bool get canAddThemes => _canAddThemes;

  switchSounds(bool value) {
    for (int n = 0; n < _sounds.length; n++) {
      _sounds[n] = value;
    }
    _setSoundSettings();
    notifyListeners();
  }

  switchGeneralSound(bool value) {
    _sounds[1] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchStartGameSound(bool value) {
    _sounds[2] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchScoreBoardSound(bool value) {
    _sounds[3] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchCorrectAnswerSound(bool value) {
    _sounds[4] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchWrongAnswerSound(bool value) {
    _sounds[5] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchInGameClearSound(bool value) {
    _sounds[6] = value;
    _setSoundSettings();
    notifyListeners();
  }

  changeCurrentTheme(int index) async {
    for (int n = 0; n < 4; n++) {
      _currentTheme[n] = _themes[index][n];
    }
    await _storeCurrentTheme();
    notifyListeners();
  }

  _getAllThemes() async {
    await _getUserThemes();
    _themes.clear();
    _themes.addAll(_defaultThemes);
    _themes.addAll(_userThemes);
    notifyListeners();
  }

  _getCurrentTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(cashedCurrentThemeData)) {
      return;
    }
    var value = prefs.getStringList(cashedCurrentThemeData);
    for (int n = 0; n < value!.length; n++) {
      _currentTheme[n] = Color(int.parse(value[n]));
    }
    notifyListeners();
  }

  _storeCurrentTheme() async {
    List<String> storedList = [];
    for (Color c in _currentTheme) {
      storedList.add(c.value.toString());
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(cashedCurrentThemeData, storedList);
    notifyListeners();
  }

  // method to get themes that user added from shared pref
  _getUserThemes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    if (!prefs.containsKey(cashedUserThemeData)) {
      return;
    }
    var value = prefs.getStringList(cashedUserThemeData);
    for (int n = 0; n < value!.length ~/ 4; n++) {
      List<Color> userColor = [];
      for (int m = 0; m < 4; m++) {
        userColor.add(Color(int.parse(value[m + n * 4])));
      }
      _userThemes.add(userColor);
    }
    notifyListeners();
  }

  // method to store themes that user added in shared pref
  _storeUserThemes() async {
    List<String> storedList = [];
    for (int n = 0; n < _userThemes.length; n++) {
      for (int m = 0; m < 4; m++) {
        storedList.add(_userThemes[n][m].value.toString());
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(cashedUserThemeData)) {
      await prefs.remove(cashedUserThemeData);
    }
    await prefs.setStringList(cashedUserThemeData, storedList);
    notifyListeners();
  }

  _getSoundSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(cashedSoundData)) {
      return;
    }
    var value = prefs.getStringList(cashedSoundData);
    for (int n = 0; n < value!.length; n++) {
      sounds[n] = int.parse(value[n]) == 0 ? false : true;
    }
    notifyListeners();
  }

  _setSoundSettings() async {
    List<String> _storedBools = [];
    for (bool b in _sounds) {
      _storedBools.add((b ? 1 : 0).toString());
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(cashedSoundData, _storedBools);
    notifyListeners();
  }

  addNewTheme(List<Color> colors) async {
    // print(colors[0].toString());
    // _defaultThemes[3] = colors;
    _userThemes.add(colors);
    _themes.add(colors);
    _storeUserThemes();
    log('added');
    notifyListeners();
  }

  deleteTheme(BuildContext context, int index) {
    if (index > defaultThemes.length - 1) {
      customAlertDialog(
          CustomColorStack(_themes[index]),
          Text(
              'This theme will be deletd even if it is a purchased theme or created theme.\nAre you sure you want to delete it ?',
              style: Theme.of(context).textTheme.headline3),
          [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: _currentTheme[0])),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                playInGameClearSound(_sounds[6]);
                _themes.removeAt(index);
                _userThemes.removeAt(index - 3);
                _storeUserThemes();
                customSnackBar('Theme deleted!');
                notifyListeners();
              },
              child: Text('Delete', style: TextStyle(color: _currentTheme[0])),
            ),
          ]);
    } else {
      customSnackBar('Original theme cannot be deleted!');
    }
  }

  unlockAddingTheme(BuildContext context, int currentCoins,
      PointsProvider pointsProvider, SettingsProvider settingsProvider) async {
    log('current coins $currentCoins');
    log('price $canAddThemePrice');
    if (currentCoins < canAddThemePrice) {
      customSnackBar(
          'You don\'t have enough Math Coins to unlock this, try to collect enough Math Coins and try again!');
    } else {
      customAlertDialog(
        const Text('Are you sure ?'),
        Text(
            'Do you want to unlock ability to add custom themes for $canAddThemePrice Math Coins\' ?',
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool(canAddThemeKey, true);
              _canAddThemes = true;
              int newCoins = currentCoins - themePrice;
              pointsProvider.updateCoins(newCoins);
              await myDatabase.mathDatabase();
            },
            child: Text('Unlock',
                style: TextStyle(color: settingsProvider.currentTheme[0])),
          ),
        ],
      );
    }
    notifyListeners();
  }

  getAddingThemeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(canAddThemeKey)) {
      await prefs.setBool(canAddThemeKey, false);
    }
    _canAddThemes = prefs.getBool(canAddThemeKey)!;
    notifyListeners();
  }
}
