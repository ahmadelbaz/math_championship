import 'package:flutter/material.dart';
import 'package:math_championship/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    _getTheme();
    _getSoundSettings();
  }

  final List<bool> _sounds = [true, true, true, true, true, true, true];

  List<bool> get sounds => _sounds;

  final Map<int, List<Color>> _themes = {
    0: [
      Colors.cyan.shade700,
      const Color.fromARGB(255, 3, 23, 61),
      const Color(0xFFECEFF1),
      const Color(0xFFFFDE03)
    ],
    1: [
      const Color(0xFFFFDE03),
      Colors.black,
      const Color(0xFF0336FF),
      Colors.pink
    ],
    2: [
      Colors.black,
      Colors.cyan,
      Colors.pink,
      Colors.yellow,
    ],
  };

  Map<int, List<Color>> get themes => _themes;

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

  switchGeneralSound(value) {
    _sounds[1] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchStartGameSound(value) {
    _sounds[2] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchScoreBoardSound(value) {
    _sounds[3] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchCorrectAnswerSound(value) {
    _sounds[4] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchWrongAnswerSound(value) {
    _sounds[5] = value;
    _setSoundSettings();
    notifyListeners();
  }

  switchInGameClearSound(value) {
    _sounds[6] = value;
    _setSoundSettings();
    notifyListeners();
  }

  changeCurrentTheme(int index) async {
    for (int n = 0; n < 4; n++) {
      _currentTheme[n] = _themes[index]![n];
    }
    await _setTheme();
    notifyListeners();
  }

  _getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(cashedThemeData)) {
      return;
    }
    var value = prefs.getStringList(cashedThemeData);
    for (int n = 0; n < value!.length; n++) {
      _currentTheme[n] = Color(int.parse(value[n]));
    }
    notifyListeners();
  }

  _setTheme() async {
    List<String> storedList = [];
    for (Color c in _currentTheme) {
      storedList.add(c.value.toString());
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(cashedThemeData, storedList);
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

  addNewTheme(List<Color> colors) {
    // print(colors[0].toString());
    _themes[3] = colors;
    notifyListeners();
  }
}
