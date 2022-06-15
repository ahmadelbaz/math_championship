import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  final List<bool> _sounds = [true, true, true, true, true, true, true];

  List<bool> get sounds => _sounds;

  final Map<int, List<Color>> _themes = {
    0: [
      const Color(0xFFFFDE03),
      Colors.black,
      const Color(0xFF0336FF),
      Colors.pink
    ],
    1: [
      Colors.cyan.shade700,
      const Color.fromARGB(255, 3, 23, 61),
      const Color(0xFFECEFF1),
      const Color(0xFFFFDE03)
    ],
    2: [
      const Color(0xFF01579B),
      Colors.white,
      Colors.pink,
      const Color(0xFFFFDE03)
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
    notifyListeners();
  }

  switchGeneralSound(value) {
    _sounds[1] = value;
    notifyListeners();
  }

  switchStartGameSound(value) {
    _sounds[2] = value;
    notifyListeners();
  }

  switchScoreBoardSound(value) {
    _sounds[3] = value;
    notifyListeners();
  }

  switchCorrectAnswerSound(value) {
    _sounds[4] = value;
    notifyListeners();
  }

  switchWrongAnswerSound(value) {
    _sounds[5] = value;
    notifyListeners();
  }

  switchInGameClearSound(value) {
    _sounds[6] = value;
    notifyListeners();
  }

  changeCurrentTheme(int index) async {
    for (int n = 0; n < 4; n++) {
      print('before : ${_currentTheme[n]}');
      _currentTheme[n] = _themes[index]![n];
      print('after : ${_currentTheme[n]}');
    }
    // _currentTheme.clear();
    // _currentTheme. addAll(_themes[index]);
    // isLightTheme.add(_themes[index]!);
    // _currentTheme = _themes[key];
    notifyListeners();
  }
}
