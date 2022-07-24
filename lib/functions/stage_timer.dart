import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/functions/timer.dart';
import 'package:math_championship/screens/start_screen.dart';

import '../main.dart';

// This method is a timer for the stage
// Stage is the 3 seconds before start any game
Future<void> stageTimer(
    T Function<T>(ProviderBase<Object?, T>) watch, BuildContext context) async {
  // Instance of providers we wanna use
  final settingsProvider = watch(settingsChangeNotifierProvider);
  final timerIntProvider = watch(timerStateIntProvider);
  final stageProvider = watch(stageStateProvider);
  // Play the start game sound
  playStartGameSound(settingsProvider.sounds[2]);
  // Assign the timer for the 3 seconds we want
  // TODO: We want to give user the ability to change this number from settings (maybe with limits)
  timerIntProvider.state = 3;
  // Assign that we are in stage phase
  stageProvider.state = true;
  const oneSec = Duration(seconds: 1);
  Timer.periodic(
    oneSec,
    (Timer timer) {
      if (timerIntProvider.state == 1) {
        timer.cancel();
        stageProvider.state = false;
        questionTimer();
      } else {
        timerIntProvider.state -= 1;
      }
    },
  );
}
