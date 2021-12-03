import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/screens/solve_mode_screen.dart';
import 'package:math_championship/screens/timeiseverthing_mode_screen.dart';

void startMode(T Function<T>(ProviderBase<Object?, T>) watch,
    BuildContext context, int index) {
  // if (index == 0) {
  watch(solveChangeNotifierProvider).setGameMode(index);
  watch(solveChangeNotifierProvider).setQuestion();
  Navigator.of(context).pushReplacementNamed('/solve_screen');
  // } else if (index == 1) {
  //   watch(timeChangeNotifierProvider).setQuestion();
  //   Navigator.of(context).pushReplacementNamed('/time_screen');
  // }
}
