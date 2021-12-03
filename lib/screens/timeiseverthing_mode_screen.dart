import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/functions/timer.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/models/mode_model.dart';
import 'package:math_championship/providers/timeiseverything_provider.dart';
import 'package:math_championship/screens/solve_mode_screen.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:math_championship/widgets/keyboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeChangeNotifierProvider =
    ChangeNotifierProvider<TimeIsEveryThingProvider>(
        (ref) => TimeIsEveryThingProvider());

class TimeIsEveryThingModeScreen extends ConsumerWidget {
  // Timer _timer = Timer(const Duration(milliseconds: 1), () {});
  bool hasFinished = false;
  @override
  Widget build(BuildContext context, watch) {
    // _questionTimer(watch);
    log('We are in TIME');
    final _size = MediaQuery.of(context).size;
    final _timeProvider = watch(timeChangeNotifierProvider);
    final _answerProvider = watch(answerStateProvider);
    final inGameProvder = watch(inGameStateProvider);
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      if (!hasFinished) {
        inGameProvder.state = true;
        hasFinished = true;
        questionTimer();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Level  ${_timeProvider.getGame().level}',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Score  ${_timeProvider.getGame().score}',
              style: const TextStyle(color: Colors.indigo),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: kMainColor,
        elevation: 0.0,
      ),
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _size.height * 0.05,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.timer,
                  size: 50,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '   ${_timeProvider.getGame().remainSeconds}',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              height: _size.height * 0.07,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_timeProvider.getGame().firstNum}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _size.width * 0.1),
                    child: Text(
                      _timeProvider.getGame().sign,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Text(
                    '${_timeProvider.getGame().secondNum}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _size.height * 0.03,
            ),
            Center(
              child: Text(_answerProvider.state),
            ),
            SizedBox(
              height: _size.height * 0.03,
            ),
            KeyboardContainer(() {
              endThis(watch, 'You ended this, try again!');
            }, () {
              log('we want to check answer');
              checkAnswer(watch);
            }, watch(timeChangeNotifierProvider)),
          ],
        ),
      ),
    );
  }

  // void _questionTimer(T Function<T>(ProviderBase<Object?, T>) watch) {
  //   final _timeProvider = watch(timeChangeNotifierProvider);
  //   _timer.cancel();
  //   _timer = Timer(
  //     const Duration(seconds: 1),
  //     () {
  //       if (_timeProvider.getGame().remainSeconds == 1) {
  //         _timer.cancel();
  //         endThis(watch, 'Time\'s Up, try again!');
  //       } else {
  //         _timeProvider
  //             .setRemainingSeconds(_timeProvider.getGame().remainSeconds - 1);
  //       }
  //     },
  //   );
  // }

  // method to check user's answer
  void checkAnswer(T Function<T>(ProviderBase<Object?, T>) watch) {
    final _timeProvider = watch(timeChangeNotifierProvider);
    final _answerProvider = watch(answerStateProvider);
    if (int.parse(_answerProvider.state) ==
        _timeProvider.getGame().trueAnswer) {
      _answerProvider.state = '';
      _timeProvider.updateScore();
      _timeProvider.setQuestion();
    } else {
      _answerProvider.state = '';
      endThis(watch, 'Wrong Answer, try again!');
    }
    if (_timeProvider.getGame().score == 70) {
      endThis(watch, 'WOWWWWW, Congratulations');
    }
  }

  // when it's over cuz user chose wrong answer or timer is over
  void endThis(
      T Function<T>(ProviderBase<Object?, T>) watch, String loseReason) async {
    final _timeProvider = watch(timeChangeNotifierProvider);
    final _modesProvider = watch(modesChangeNotifierProvider);
    // message to show to user in result screen ( if he got new high score it tells him)
    String message = 'Keep going';
    // 2 variables to throw score and highScore to result screen
    String score = '${_timeProvider.getGame().score}';
    String highScore = '${_modesProvider.modes[1].highScore}';
    // string that shows the question that user didn't solve or answered it wrong
    String lastQs =
        '${_timeProvider.getGame().firstNum}     ${_timeProvider.getGame().sign}     ${_timeProvider.getGame().secondNum}     =     ${_timeProvider.getGame().trueAnswer}';
    if (_timeProvider.getGame().score > _modesProvider.modes[1].highScore) {
      message = 'Congrats, you got new High Score';
      Mode mode = Mode(
          id: _modesProvider.modes[1].id,
          name: _modesProvider.modes[1].name,
          highScore: _timeProvider.getGame().score,
          highScoreDateTime: DateTime.now());
      await _modesProvider.updateHighScore(mode, _modesProvider.modes[1].id);
    }
    log(' this is score ${_timeProvider.getGame().score}');
    if (_timeProvider.getGame().score == 70) {
      message = 'You are winner!!';
    }
    watch(answerStateProvider).state = '';
    _timeProvider.resetGame();
    navigatorKey.currentState!.pushReplacementNamed(
      '/result_screen',
      arguments: [
        loseReason,
        message,
        score,
        highScore,
        lastQs,
        '/time_screen',
        '1'
      ],
    );
  }
}
