import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/select_current_provider.dart';
import 'package:math_championship/functions/stage_timer.dart';

import '../main.dart';
import '../screens/start_screen.dart';

// We call this method when user click on mode to start playing it.
void startMode(T Function<T>(ProviderBase<Object?, T>) watch,
    BuildContext context, int index) async {
  // We choose the right provider for the mode
  watch(modeStateProvider).state = index;
  // We set the first question
  selectCurrentProvider(watch).setQuestion();
  // Start stage phase to count the 3 seconds before the game starts
  watch(stageStateProvider).state = true;
  // Assign that we are in game provider
  watch(inGameStateProvider).state = true;
  // Navigate to game screen to start counting and playing
  Navigator.of(context).pushReplacementNamed('/game_screen');
  // Start the stage timer to start counting
  await stageTimer(watch, context);
}
