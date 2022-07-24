import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/functions/select_current_provider.dart';
import 'package:math_championship/main.dart';

import 'package:math_championship/screens/game_screen.dart';
import 'package:math_championship/screens/start_screen.dart';

// We call this method when it's over because user chose wrong answer, timer is over or he decided to end the game
Future<void> endThis(String lossReason) async {
  // we get context ftom globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;
  // Instance of providers
  final gameProvider = selectCurrentProvider(context!.read);
  final modeProvider = context.read(modeStateProvider);
  final modesProvider = context.read(modesChangeNotifierProvider);
  final settingsProvider = context.read(settingsChangeNotifierProvider);
  // Play 'endthis' sound if its enabled
  playGameOverSound(settingsProvider.sounds[4]);
  // message to show to user in result screen ( if he got new high score it tells him)
  String message = 'Keep going';
  // 2 variables to show score and highScore to result screen
  String score = '${gameProvider.gameModel.score}';
  String highScore = '${modesProvider.modes[modeProvider.state].highScore}';
  // string that shows the question that user didn't solve or answered it wrong
  String lastQuestionFirstNum = '${gameProvider.gameModel.firstNum}';
  String lastQuestionSign = gameProvider.gameModel.sign;
  String lastQuestionSecondNum = '${gameProvider.gameModel.secondNum}';
  String lastQuestionAnswer = '${gameProvider.gameModel.trueAnswer}';
  // Check if user got new high score
  if (gameProvider.gameModel.score >
      modesProvider.modes[modeProvider.state].highScore) {
    message = 'Congrats🎉 you got new High Score';
    await modesProvider.updateHighScore(gameProvider.gameModel.score,
        modesProvider.modes[modeProvider.state].id);
  }
  // Check if user won the game (fot 70 points)
  if (gameProvider.gameModel.score == 70) {
    message = 'You are winner!!';
  }
  // Clear answer provider because the game ended
  context.read(answerStateProvider).state = '';
  gameProvider.resetGame();
  // close inGame provider
  context.read(inGameStateProvider).state = false;
  // Navigate to result screen with needed data
  navigatorKey.currentState!.pushReplacementNamed(
    '/result_screen',
    arguments: [
      lossReason,
      message,
      score,
      highScore,
      lastQuestionFirstNum,
      lastQuestionSign,
      lastQuestionSecondNum,
      lastQuestionAnswer,
      '/game_screen',
      modeProvider.state.toString()
    ],
  );
}
