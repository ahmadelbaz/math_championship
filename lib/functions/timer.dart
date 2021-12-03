import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/end_this.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/screens/solve_mode_screen.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:math_championship/screens/timeiseverthing_mode_screen.dart';

void questionTimer() {
  // we get context ftom globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;
  // Timer? _timer = context!.read(timerStateProvider).state;
  Timer? _timer = Timer(const Duration(milliseconds: 1), () {});
  // log('timer 1 ${_timer.isActive}');
  final _gameProvider = context!.read(solveChangeNotifierProvider);
  final _timeProvider = context.read(timeChangeNotifierProvider);
  final _usedProvider = _gameProvider;
  // if (_timer != null) {
  // _timer.cancel();
  // _timer = null;
  // }
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    // log('showwww ${context.read(timerStateProvider).state.isActive}');
    // if (context.read(timerStateProvider).state.isActive) {
    //   timer.cancel();
    // }
    // log('timer 2 ${timer.isActive}');
    log('in game ? ${context.read(inGameStateProvider).state}');
    if (!context.read(inGameStateProvider).state) {
      log('error 1');
      timer.cancel();
    } else if (_gameProvider.getGame().remainSeconds == 1) {
      log('error 2');
      timer.cancel();
      endThis('Time\'s Up, try again!');
    } else {
      log('error 3');
      _gameProvider
          .setRemainingSeconds(_gameProvider.getGame().remainSeconds - 1);
    }
  });
}


// void questionTimer(
//     T Function<T>(ProviderBase<Object?, T>) watch) {
//   final _gameProvider = watch(gameChangeNotifierProvider);
//   final _timer = watch(timerProvider);
//   _timer.state.cancel();
//   _timer.state = Timer(
//     const Duration(seconds: 1),
//     () {
//       if (_gameProvider.getGame().remainSeconds == 1) {
//         _timer.cancel();
//         // endThis(watch);
//       } else {
//         _gameProvider
//             .setRemainingSeconds(_gameProvider.getGame().remainSeconds - 1);
//       }
//     },
//   );
// }
