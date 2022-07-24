import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/end_this.dart';
import 'package:math_championship/functions/select_current_provider.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/screens/start_screen.dart';

// Important timer, for every question we stop it and start it again (except for 'TimeIsEverything' mode)
void questionTimer() {
  // we get context from globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;
  final gameProvider = selectCurrentProvider(context!.read);
  // We set the timer to state provider to that we can controll it in game and restart it
  context.read(timerStateProvider).state = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      if (!context.read(inGameStateProvider).state) {
        timer.cancel();
      } else if (gameProvider.gameModel.remainSeconds == 1) {
        timer.cancel();
        endThis('Time\'s Up, try again!');
      } else {
        gameProvider
            .setRemainingSeconds(gameProvider.gameModel.remainSeconds - 1);
      }
    },
  );
}
