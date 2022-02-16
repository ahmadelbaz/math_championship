import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/models/mode_model.dart';

// when it's over cuz user chose wrong answer or timer is over
import 'package:math_championship/screens/game_screen.dart';
import 'package:math_championship/screens/start_screen.dart';

import 'game_over_sound.dart';

Future<void> endThis(String loseReason) async {
  playGameOverSound();
  // we get context ftom globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;
  final _solveProvider = context?.read(solveChangeNotifierProvider);
  final _modesProvider = context?.read(modesChangeNotifierProvider);
  // message to show to user in result screen ( if he got new high score it tells him)
  String message = 'Keep going';
  // 2 variables to throw score and highScore to result screen
  String score = '${_solveProvider!.getGame().score}';
  String highScore =
      '${_modesProvider!.modes[_solveProvider.getGameMode()].highScore}';
  // string that shows the question that user didn't solve or answered it wrong
  String lastQs =
      '${_solveProvider.getGame().firstNum}     ${_solveProvider.getGame().sign}     ${_solveProvider.getGame().secondNum}     =     ${_solveProvider.getGame().trueAnswer}';
  if (_solveProvider.getGame().score >
      _modesProvider.modes[_solveProvider.getGameMode()].highScore) {
    message = 'Congrats, you got new High Score';
    Mode mode = Mode(
        id: _modesProvider.modes[_solveProvider.getGameMode()].id,
        name: _modesProvider.modes[_solveProvider.getGameMode()].name,
        highScore: _solveProvider.getGame().score,
        highScoreDateTime: DateTime.now());
    await _modesProvider.updateHighScore(
        mode, _modesProvider.modes[_solveProvider.getGameMode()].id);
  }
  log(' this is score ${_solveProvider.getGame().score}');
  if (_solveProvider.getGame().score == 70) {
    message = 'You are winner!!';
  }
  context!.read(answerStateProvider).state = '';
  _solveProvider.resetGame();
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
      '/solve_screen',
      _solveProvider.getGameMode().toString()
    ],
  );
}
