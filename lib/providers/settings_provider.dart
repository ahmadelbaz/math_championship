import 'dart:collection';
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
import 'achievement_provider.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    _getMainFont();
    _getSecondaryFont();
    _getCurrentTheme();
    _getAllThemes();
    _getAllFonts();
    _getSoundSettings();
    getAddingThemeValue();
  }

  bool _isFirstTimeApp = true;
  bool get isFirstTimeApp => _isFirstTimeApp;

  MyDatabase myDatabase = MyDatabase();

  final List<bool> _sounds = [true, true, true, true, true, true, true];
  List<bool> get sounds => _sounds;

  final List<List<Color>> _userThemes = [];
  List<List<Color>> get userThemes => _userThemes;

  List<String> _userFonts = [];
  List<String> get userFonts => _userFonts;

  final List<List<Color>> _themes = [];
  List<List<Color>> get themes => _themes;

  final List<String> _fonts = [];
  List<String> get fonts => _fonts;

  final List<List<Color>> _defaultThemes = [
    firstTheme,
    secondTheme,
    thirdTheme,
  ];
  List<List<Color>> get defaultThemes => _defaultThemes;

  final List<Color> _currentTheme = [
    const Color(0xFFFFDE03),
    Colors.black,
    Colors.pink,
    const Color(0xFF0336FF),
  ];
  List<Color> get currentTheme => _currentTheme;

  final List<String> _defaultFonts = [
    firstFont,
    secondFont,
    // thirdFont,
    // fourthFont,
    // fifthFont
  ];
  UnmodifiableListView get defaultFonts => UnmodifiableListView(_defaultFonts);
  String _mainFont = firstFont;
  String get mainFont => _mainFont;
  String _secondaryFont = secondFont;
  String get secondaryFont => _secondaryFont;

  bool _canAddThemes = false;
  bool get canAddThemes => _canAddThemes;

  setIsFirstTime(bool value) {
    _isFirstTimeApp = value;
    notifyListeners();
  }

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

  _getAllFonts() async {
    await _getUserFonts();
    _fonts.clear();
    _fonts.addAll(_defaultFonts);
    _fonts.addAll(_userFonts);
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

  // method to get Fonts that user added from shared pref
  _getUserFonts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    if (!prefs.containsKey(cashedUserFontData)) {
      return;
    }
    var value = prefs.getStringList(cashedUserFontData);
    _userFonts = value!;
    notifyListeners();
  }

  // method to store themes that user added in shared pref
  _storeUserFonts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(cashedUserFontData)) {
      await prefs.remove(cashedUserFontData);
    }
    await prefs.setStringList(cashedUserFontData, _userFonts);
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
    List<String> storedBools = [];
    for (bool b in _sounds) {
      storedBools.add((b ? 1 : 0).toString());
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(cashedSoundData, storedBools);
    notifyListeners();
  }

  addNewTheme(List<Color> colors, AchievementProvider achievementProvider,
      PointsProvider pointsProvider, bool addNewThemeAchievement) async {
    // print(colors[0].toString());
    // _defaultThemes[3] = colors;
    _userThemes.add(colors);
    _themes.add(colors);
    _storeUserThemes();
    log('added');
    if (addNewThemeAchievement) {
      // achievement : Create new theme
      achievementProvider.checkAchievement(5, pointsProvider);
    }
    notifyListeners();
  }

  addNewFont(
    String font,
    AchievementProvider achievementProvider,
    PointsProvider pointsProvider,
  ) async {
    // print(colors[0].toString());
    // _defaultThemes[3] = colors;
    _userFonts.add(font);
    _fonts.add(font);
    _storeUserFonts();
    log('added');
    // achievementProvider.checkAchievement(3, pointsProvider);
    notifyListeners();
  }

  deleteTheme(BuildContext context, int index) {
    if (index > defaultThemes.length - 1) {
      customAlertDialog(
          customColorStack(_themes[index]),
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
              child: Text(
                'Delete',
                style: TextStyle(
                  color: _currentTheme[0],
                ),
              ),
            ),
          ]);
    } else {
      customSnackBar('Original theme cannot be deleted!');
    }
  }

  deleteFont(BuildContext context, int index) {
    if (index > defaultFonts.length - 1) {
      customAlertDialog(
          Text(
            'Select',
            style: TextStyle(fontFamily: _fonts[index]),
          ),
          Text(
              'This font will be deletd even if it is a purchased font.\nAre you sure you want to delete it ?',
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
                _fonts.removeAt(index);
                _userFonts.removeAt(index - 2);
                _storeUserFonts();
                customSnackBar('Font deleted!');
                notifyListeners();
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: _currentTheme[0],
                ),
              ),
            ),
          ]);
    } else {
      customSnackBar('Original Font cannot be deleted!');
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
        const FittedBox(child: Text('Are you sure ?')),
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
              // await myDatabase.mathDatabase();
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

  setMainFont(String font) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(mainFontKey, font);
    _mainFont = font;
    notifyListeners();
  }

  _getMainFont() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(mainFontKey)) {
      await prefs.setString(mainFontKey, firstFont);
    }
    _mainFont = prefs.getString(mainFontKey)!;
    notifyListeners();
  }

  setSecondaryFont(String font) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(secondaryFontKey, font);
    _secondaryFont = font;
    notifyListeners();
  }

  _getSecondaryFont() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(secondaryFontKey)) {
      await prefs.setString(secondaryFontKey, secondFont);
    }
    _secondaryFont = prefs.getString(secondaryFontKey)!;
    notifyListeners();
  }
}
