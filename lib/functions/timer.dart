import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/end_this.dart';
import 'package:math_championship/functions/select_current_provider.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/screens/start_screen.dart';

void questionTimer() {
  // we get context ftom globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;
  final _gameProvider = selectCurrentProvider(context!.read);
  Timer.periodic(
    const Duration(milliseconds: 1),
    (timer) {
      if (!context.read(inGameStateProvider).state) {
        timer.cancel();
      } else if (_gameProvider.gameModel.remainSeconds == 1) {
        timer.cancel();
        endThis('Time\'s Up, try again!');
      } else {
        _gameProvider
            .setRemainingSeconds(_gameProvider.gameModel.remainSeconds - 1);
      }
    },
  );
}
