import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/stage_timer.dart';
import 'package:math_championship/screens/game_screen.dart';

import '../screens/start_screen.dart';

void startMode(T Function<T>(ProviderBase<Object?, T>) watch,
    BuildContext context, int index) async {
  watch(solveChangeNotifierProvider).setGameMode(index);
  watch(solveChangeNotifierProvider).setQuestion();
  watch(stageStateProvider).state = true;
  watch(inGameStateProvider).state = true;
  await stageTimer(watch, context);
  Navigator.of(context).pushReplacementNamed('/solve_screen');
}
