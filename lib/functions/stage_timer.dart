import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/functions/timer.dart';
import 'package:math_championship/screens/start_screen.dart';

import '../main.dart';

Future<void> stageTimer(
    T Function<T>(ProviderBase<Object?, T>) watch, BuildContext context) async {
  final settingsProvider = watch(settingsChangeNotifierProvider);
  final timerIntProvider = watch(timerStateIntProvider);
  final stageProvider = watch(stageStateProvider);
  playStartGameSound(settingsProvider.sounds[2]);
  timerIntProvider.state = 3;
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
