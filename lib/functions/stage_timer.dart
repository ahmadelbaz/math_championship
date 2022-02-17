import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/screens/start_screen.dart';

Future<void> stageTimer(
    T Function<T>(ProviderBase<Object?, T>) watch, BuildContext context) async {
  playStartNewGameSound();
  watch(timerProvider).state = 3;
  watch(stageStateProvider).state = true;
  const oneSec = Duration(seconds: 1);
  Timer _timer = Timer.periodic(
    oneSec,
    (Timer timer) {
      if (watch(timerProvider).state == 1) {
        // startMode(watch, context, index);
        timer.cancel();
        watch(stageStateProvider).state = false;
      } else {
        watch(timerProvider).state -= 1;
      }
    },
  );
}
