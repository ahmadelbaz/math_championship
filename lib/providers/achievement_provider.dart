import 'package:flutter/material.dart';
import 'package:math_championship/models/achievement.dart';

class AchievementProvider extends ChangeNotifier {
  final List<Achievement> _achievements = [];
  List<Achievement> get achievements => _achievements;
}
