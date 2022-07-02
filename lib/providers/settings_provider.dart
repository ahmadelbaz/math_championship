import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    _getCurrentTheme();
    _getAllThemes();
    _getSoundSettings();
  }

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

  deleteTheme(int index) {
    if (index > 2) {
      playInGameClearSound(_sounds[6]);
      _themes.removeAt(index);
      _userThemes.removeAt(index - 3);
      _storeUserThemes();
      notifyListeners();
    }
  }
}
