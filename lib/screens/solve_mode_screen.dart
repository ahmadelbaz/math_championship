import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/end_this.dart';
import 'package:math_championship/functions/timer.dart';
import 'package:math_championship/providers/solve_mode_provider.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:math_championship/widgets/keyboard.dart';
import '../constants.dart';

final solveChangeNotifierProvider =
    ChangeNotifierProvider<SolveModeProvider>((ref) => SolveModeProvider());

// final timerStateProvider = StateProvider<Timer>((ref) {
//   return Timer(const Duration(milliseconds: 1), () {});
// });

final answerStateProvider = StateProvider<String>((ref) => '');

// final timeFutureProvider = FutureProvider((ref) async {
//   final _gameProvider = ref.read(solveChangeNotifierProvider);
//   // final _timerProvider = ref.read(timerStateProvider);
//   // Timer _timer = Timer(const Duration(milliseconds: 1), () {});
//   WidgetsBinding.instance!.addPostFrameCallback((duration) {
//     // questionTimer();
//   });
// });

class SolveModeScreen extends ConsumerWidget {
  bool hasFinished = false;
  // Timer _timer = Timer(const Duration(milliseconds: 1), () {});
  // int _answer = 0;
  @override
  Widget build(BuildContext context, watch) {
    // _questionTimer(watch);
    final _size = MediaQuery.of(context).size;
    final _solveProvider = watch(solveChangeNotifierProvider);
    final _answerProvider = watch(answerStateProvider);
    // final futureProvider = watch(timeFutureProvider);
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
              'Level  ${_solveProvider.getGame().level}',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Score  ${_solveProvider.getGame().score}',
              style: const TextStyle(color: Colors.indigo),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: kMainColor,
        elevation: 0.0,
      ),
      backgroundColor: kMainColor,
      body:
          // futureProvider.when(
          //   data: (data) {
          //     // questionTimer();
          //     return
          SingleChildScrollView(
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
                  '   ${_solveProvider.getGame().remainSeconds}',
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
                    '${_solveProvider.getGame().firstNum}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _size.width * 0.1),
                    child: Text(
                      _solveProvider.getGame().sign,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Text(
                    '${_solveProvider.getGame().secondNum}',
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
              endThis('You ended this, try again!');
            }, () {
              log('we want to check answer');
              checkAnswer(watch);
            }, watch(solveChangeNotifierProvider)),
          ],
        ),
      ),
      //   },
      //   loading: () => const Center(child: CircularProgressIndicator()),
      //   error: (e, st) => Center(child: Text('Error: $e')),
      // ),
    );
  }

  // method to check user's answer
  void checkAnswer(T Function<T>(ProviderBase<Object?, T>) watch) {
    final _gameProvider = watch(solveChangeNotifierProvider);
    final _answerProvider = watch(answerStateProvider);
    // _timer.cancel();
    if (int.parse(_answerProvider.state) ==
        _gameProvider.getGame().trueAnswer) {
      _answerProvider.state = '';
      _gameProvider.updateScore();
      _gameProvider.setQuestion();
    } else {
      _answerProvider.state = '';
      endThis('Wrong Answer, try again!');
    }
    if (_gameProvider.getGame().score == 70) {
      endThis('WOWWWWW, Congratulations');
    }
  }

  // // when it's over cuz user chose wrong answer or timer is over
  // void endThis(
  //     T Function<T>(ProviderBase<Object?, T>) watch, String loseReason) async {
  //   final _solveProvider = watch(solveChangeNotifierProvider);
  //   final _modesProvider = watch(modesChangeNotifierProvider);
  //   // message to show to user in result screen ( if he got new high score it tells him)
  //   String message = 'Keep going';
  //   // 2 variables to throw score and highScore to result screen
  //   String score = '${_solveProvider.getGame().score}';
  //   String highScore = '${_modesProvider.modes[0].highScore}';
  //   // string that shows the question that user didn't solve or answered it wrong
  //   String lastQs =
  //       '${_solveProvider.getGame().firstNum}     ${_solveProvider.getGame().sign}     ${_solveProvider.getGame().secondNum}     =     ${_solveProvider.getGame().trueAnswer}';
  //   if (_solveProvider.getGame().score > _modesProvider.modes[0].highScore) {
  //     message = 'Congrats, you got new High Score';
  //     Mode mode = Mode(
  //         id: _modesProvider.modes[0].id,
  //         name: _modesProvider.modes[0].name,
  //         highScore: _solveProvider.getGame().score,
  //         highScoreDateTime: DateTime.now());
  //     await _modesProvider.updateHighScore(mode, _modesProvider.modes[0].id);
  //   }
  //   log(' this is score ${_solveProvider.getGame().score}');
  //   if (_solveProvider.getGame().score == 70) {
  //     message = 'You are winner!!';
  //   }
  //   watch(answerStateProvider).state = '';
  //   _solveProvider.resetGame();
  //   navigatorKey.currentState!.pushReplacementNamed(
  //     '/result_screen',
  //     arguments: [
  //       loseReason,
  //       message,
  //       score,
  //       highScore,
  //       lastQs,
  //       '/solve_screen',
  //       '0'
  //     ],
  //   );
  // }
}
