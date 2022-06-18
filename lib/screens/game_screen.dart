import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/end_this.dart';
import 'package:math_championship/providers/game_provider.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:math_championship/widgets/keyboard.dart';
import '../functions/play_sounds.dart';
import '../main.dart';

final solveChangeNotifierProvider =
    ChangeNotifierProvider<SolveProvider>((ref) => SolveProvider());

final answerStateProvider = StateProvider<String>((ref) => '');

final widthStateProvider = StateProvider<double>((ref) => 10.0);

class GameScreen extends ConsumerWidget {
  const GameScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    final _solveProvider = watch(solveChangeNotifierProvider);
    final _answerProvider = watch(answerStateProvider);
    final widthProvider = watch(widthStateProvider);
    final _stageProvider = watch(stageStateProvider);
    final _timerProvider = watch(timerProvider);
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: _settingsProvider.currentTheme[0],
          elevation: 0.0,
        ),
        backgroundColor: _settingsProvider.currentTheme[0],
        body: _stageProvider.state
            ? Center(
                child: Text(
                  '${_timerProvider.state}',
                  style: const TextStyle(fontSize: 60),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: _size.height * 0.05,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer,
                          size: 50,
                          color: Theme.of(context).primaryColor,
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
                      height: _size.height * 0.1,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: widthProvider.state),
                        borderRadius: BorderRadius.all(
                          Radius.circular(_size.width * 0.06),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_solveProvider.getGame().firstNum}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: _size.width * 0.1),
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
      ),
    );
  }

  // method to check user's answer
  void checkAnswer(T Function<T>(ProviderBase<Object?, T>) watch) {
    final _gameProvider = watch(solveChangeNotifierProvider);
    final _answerProvider = watch(answerStateProvider);
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    if (int.parse(_answerProvider.state) ==
        _gameProvider.getGame().trueAnswer) {
      playCorrectAnswerSound(_settingsProvider.sounds[4]);
      _answerProvider.state = '';
      _gameProvider.updateScore();
      _gameProvider.setQuestion();
      if (watch(widthStateProvider).state == 1) {
        watch(widthStateProvider).state = 5;
      } else {
        watch(widthStateProvider).state = 1;
      }
    } else {
      _answerProvider.state = '';
      endThis('Wrong Answer, try again!');
    }
    if (_gameProvider.getGame().score == 70) {
      endThis('WOWWWWW, Congratulations');
    }
  }
}
