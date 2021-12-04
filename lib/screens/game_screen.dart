import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/end_this.dart';
import 'package:math_championship/functions/timer.dart';
import 'package:math_championship/providers/game_provider.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:math_championship/widgets/keyboard.dart';
import '../constants.dart';

final solveChangeNotifierProvider =
    ChangeNotifierProvider<GameProvider>((ref) => GameProvider());

final answerStateProvider = StateProvider<String>((ref) => '');

class GameScreen extends ConsumerWidget {
  bool hasFinished = false;

  GameScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    final _solveProvider = watch(solveChangeNotifierProvider);
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
    );
  }

  // method to check user's answer
  void checkAnswer(T Function<T>(ProviderBase<Object?, T>) watch) {
    final _gameProvider = watch(solveChangeNotifierProvider);
    final _answerProvider = watch(answerStateProvider);
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
}
