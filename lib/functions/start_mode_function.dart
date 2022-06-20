import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/select_current_provider.dart';
import 'package:math_championship/functions/stage_timer.dart';

import '../main.dart';
import '../screens/start_screen.dart';

void startMode(T Function<T>(ProviderBase<Object?, T>) watch,
    BuildContext context, int index) async {
  print('THIS IS INDEX $index');
  watch(modeStateProvider).state = index;
  // selectCurrentProvider(watch).setGameMode(index);
  selectCurrentProvider(watch).setQuestion();
  watch(stageStateProvider).state = true;
  watch(inGameStateProvider).state = true;
  await stageTimer(watch, context);
  Navigator.of(context).pushReplacementNamed('/game_screen');
}
