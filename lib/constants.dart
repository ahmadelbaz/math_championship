import 'package:flutter/material.dart';

List<Color> firstTheme = [
  const Color(0xFFFFDE03),
  Colors.black,
  Colors.pink,
  const Color(0xFF0336FF),
];
List<Color> secondTheme = [
  Colors.cyan.shade700,
  const Color.fromARGB(255, 3, 23, 61),
  const Color(0xFFECEFF1),
  const Color(0xFFFFDE03)
];
const List<Color> thirdTheme = [
  Colors.black,
  Colors.cyan,
  Colors.pink,
  Colors.yellow,
];

const youEndedThisAnimation = 'assets/animations/uendedthis.json';

const timeIsUpAnimation = 'assets/animations/time.json';

const wrongAnswerAnimation = 'assets/animations/sadrobot.json';

const cashedCurrentThemeData = 'cashed_current_theme_data';
const cashedUserThemeData = 'cashed_User_theme_data';
const cashedUserFontData = 'cashed_User_Font_data';
const cashedSoundData = 'cashed_sound_data';
const themePrice = 10;
const fontPrice = 10;
const canAddThemePrice = 50;

const canAddThemeKey = 'can_add_theme';
const isFirstTimeKey = 'first_time';
const mainFontKey = 'main_font';
const secondaryFontKey = 'secondary_font';

const firstFont = 'wheaton-capitals';
const secondFont = 'rimouski';
const thirdFont = 'BubblegumSans';
const fourthFont = 'MotionControl-Bold';
const fifthFont = '';

var deviceWidth = 0.0;
var deviceHeight = 0.0;
