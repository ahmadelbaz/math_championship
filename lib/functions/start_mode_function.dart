import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/screens/game_screen.dart';

void startMode(T Function<T>(ProviderBase<Object?, T>) watch,
    BuildContext context, int index) {
  watch(solveChangeNotifierProvider).setGameMode(index);
  watch(solveChangeNotifierProvider).setQuestion();
  // watch(stageStateProvider);
  Navigator.of(context).pushReplacementNamed('/solve_screen');
}
