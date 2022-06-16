import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/functions/timer.dart';
import 'package:math_championship/screens/start_screen.dart';

import '../main.dart';

Future<void> stageTimer(
    T Function<T>(ProviderBase<Object?, T>) watch, BuildContext context) async {
  final _settingsProvider = watch(settingsChangeNotifierProvider);
  final _timerProvider = watch(timerProvider);
  final _stageStateProvider = watch(stageStateProvider);
  playStartGameSound(_settingsProvider.sounds[2]);
  _timerProvider.state = 3;
  _stageStateProvider.state = true;
  const oneSec = Duration(seconds: 1);
  Timer.periodic(
    oneSec,
    (Timer timer) {
      if (_timerProvider.state == 1) {
        timer.cancel();
        _stageStateProvider.state = false;
        questionTimer();
      } else {
        _timerProvider.state -= 1;
      }
    },
  );
}
