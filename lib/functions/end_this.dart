import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/functions/select_current_provider.dart';
import 'package:math_championship/main.dart';

// when it's over cuz user chose wrong answer or timer is over
import 'package:math_championship/screens/game_screen.dart';
import 'package:math_championship/screens/start_screen.dart';

Future<void> endThis(String loseReason) async {
  // we get context ftom globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;
  final gameProvider = selectCurrentProvider(context!.read);
  final modeProvider = context.read(modeStateProvider);
  // context?.read(solveChangeNotifierProvider);
  final modesProvider = context.read(modesChangeNotifierProvider);
  final settingsProvider = context.read(settingsChangeNotifierProvider);
  // Play 'endthis' sound if its enabled
  playGameOverSound(settingsProvider.sounds[4]);
  // message to show to user in result screen ( if he got new high score it tells him)
  String message = 'Keep going';
  // 2 variables to throw score and highScore to result screen
  String score = '${gameProvider.gameModel.score}';
  String highScore = '${modesProvider.modes[modeProvider.state].highScore}';
  // string that shows the question that user didn't solve or answered it wrong
  String lastQs =
      '${gameProvider.gameModel.firstNum}     ${gameProvider.gameModel.sign}     ${gameProvider.gameModel.secondNum}     =     ${gameProvider.gameModel.trueAnswer}';
  if (gameProvider.gameModel.score >
      modesProvider.modes[modeProvider.state].highScore) {
    message = 'Congrats🎉 you got new High Score';
    await modesProvider.updateHighScore(gameProvider.gameModel.score,
        modesProvider.modes[modeProvider.state].id);
  }
  log(' this is score ${gameProvider.gameModel.score}');
  if (gameProvider.gameModel.score == 70) {
    message = 'You are winner!!';
  }
  context.read(answerStateProvider).state = '';
  gameProvider.resetGame();
  // close inGame provider
  context.read(inGameStateProvider).state = false;
  log('after game ? ${context.read(inGameStateProvider).state}');
  navigatorKey.currentState!.pushReplacementNamed(
    '/result_screen',
    arguments: [
      loseReason,
      message,
      score,
      highScore,
      lastQs,
      '/game_screen',
      modeProvider.state.toString()
    ],
  );
}
