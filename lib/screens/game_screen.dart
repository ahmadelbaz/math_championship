import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/end_this.dart';
import 'package:math_championship/functions/select_current_provider.dart';
import 'package:math_championship/providers/double_value_provider.dart';
import 'package:math_championship/providers/random_sign_provider.dart';
import 'package:math_championship/providers/solve_provider.dart';
import 'package:math_championship/providers/square_root_provider.dart';
import 'package:math_championship/providers/time_iseverything_provider.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:math_championship/widgets/keyboard.dart';
import '../functions/play_sounds.dart';
import '../functions/timer.dart';
import '../main.dart';

final solveChangeNotifierProvider =
    ChangeNotifierProvider<SolveProvider>((ref) => SolveProvider());
final timeIsEveryThingChangeNotifierProvider =
    ChangeNotifierProvider<TimeIsEverythingProvider>(
        (ref) => TimeIsEverythingProvider());
final randomSignChangeNotifierProvider =
    ChangeNotifierProvider<RandomSignProvider>((ref) => RandomSignProvider());
final doubleValueChangeNotifierProvider =
    ChangeNotifierProvider<DoubleValueProvider>((ref) => DoubleValueProvider());
final squareRootChangeNotifierProvider =
    ChangeNotifierProvider<SquareRootProvider>((ref) => SquareRootProvider());

final answerStateProvider = StateProvider<String>((ref) => '');

final widthStateProvider = StateProvider<double>((ref) => 10.0);

class GameScreen extends ConsumerWidget {
  const GameScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, watch) {
    final size = MediaQuery.of(context).size;
    final gameProvider = selectCurrentProvider(watch);
    final answerProvider = watch(answerStateProvider);
    final widthProvider = watch(widthStateProvider);
    final stageProvider = watch(stageStateProvider);
    final timerIntProvider = watch(timerStateIntProvider);
    final settingsProvider = watch(settingsChangeNotifierProvider);
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
                'Level  ${gameProvider.gameModel.level}',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                'Score  ${gameProvider.gameModel.score}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: settingsProvider.currentTheme[0],
          elevation: 0.0,
        ),
        backgroundColor: settingsProvider.currentTheme[0],
        body: stageProvider.state
            ? Center(
                child: Text(
                  '${timerIntProvider.state}',
                  style: TextStyle(
                      fontSize: 60, color: Theme.of(context).primaryColor),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
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
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                value: watch(modeStateProvider).state == 2
                                    ? gameProvider.gameModel.remainSeconds / 30
                                    : gameProvider.gameModel.remainSeconds / 5,
                                strokeWidth: 12,
                                valueColor: AlwaysStoppedAnimation(
                                    settingsProvider.currentTheme[3]),
                                backgroundColor:
                                    settingsProvider.currentTheme[1],
                              ),
                              Center(
                                child: Text(
                                  '${gameProvider.gameModel.remainSeconds}',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Container(
                      height: size.height * 0.1,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: widthProvider.state),
                        borderRadius: BorderRadius.all(
                          Radius.circular(size.width * 0.06),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${gameProvider.gameModel.firstNum}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
                            child: Text(
                              gameProvider.gameModel.sign,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Text(
                            '${gameProvider.gameModel.secondNum}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Center(
                      child: Text(
                        answerProvider.state,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    KeyboardContainer(() {
                      endThis('You ended this, try again!');
                    }, () {
                      log('we want to check answer');
                      checkAnswer(watch);
                    }, gameProvider),
                  ],
                ),
              ),
      ),
    );
  }

  // method to check user's answer
  void checkAnswer(T Function<T>(ProviderBase<Object?, T>) watch) {
    final gameProvider = selectCurrentProvider(watch);
    final answerProvider = watch(answerStateProvider);
    final settingsProvider = watch(settingsChangeNotifierProvider);
    if (int.parse(answerProvider.state) == gameProvider.gameModel.trueAnswer) {
      playCorrectAnswerSound(settingsProvider.sounds[4]);
      if (watch(modeStateProvider).state != 2) {
        watch(timerStateProvider).state.cancel();
        questionTimer();
      }
      answerProvider.state = '';
      gameProvider.updateScore();
      gameProvider.setQuestion();
      if (watch(widthStateProvider).state == 1) {
        watch(widthStateProvider).state = 5;
      } else {
        watch(widthStateProvider).state = 1;
      }
    } else {
      answerProvider.state = '';
      endThis('Wrong Answer, try again!');
    }
    if (gameProvider.gameModel.score == 70) {
      endThis('WOWWWWW, Congratulations');
    }
  }
}
