import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/functions/end_this.dart';
import 'package:math_championship/functions/select_current_provider.dart';
import 'package:math_championship/providers/double_value_provider.dart';
import 'package:math_championship/providers/random_sign_provider.dart';
import 'package:math_championship/providers/solve_provider.dart';
import 'package:math_championship/providers/square_root_provider.dart';
import 'package:math_championship/providers/time_iseverything_provider.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:math_championship/widgets/keyboard.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
// import 'package:simple_animations/simple_animations.dart' as simple_animations;
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

// final widthStateProvider = StateProvider<double>((ref) => 5.0);

enum AnimProps {
  opacity,
  width,
  height,
  padding,
  borderRadius,
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<TimelineValue<dynamic>> animation;

  late Animation<double> opacity;
  late Animation<double> width;
  late Animation<double> height;
  late Animation<EdgeInsets> padding;
  late Animation<BorderRadius?> borderRadius;
  // late Animation<Color?> color;

  @override
  void initState() {
    super.initState();
    log('width : $deviceWidth');
    controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.100,
          curve: Curves.ease,
        ),
      ),
    );
    width = Tween<double>(
      begin: 50.0,
      end: 600,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.125,
          0.250,
          curve: Curves.ease,
        ),
      ),
    );
    height = Tween<double>(begin: 0.0, end: 80.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.250,
          0.375,
          curve: Curves.ease,
        ),
      ),
    );
    padding = EdgeInsetsTween(
      begin: const EdgeInsets.symmetric(horizontal: 0.0),
      end: const EdgeInsets.symmetric(horizontal: 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.250,
          0.375,
          curve: Curves.ease,
        ),
      ),
    );
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(deviceWidth * 0.06),
      end: BorderRadius.circular(deviceWidth * 0.06),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.375,
          0.500,
          curve: Curves.ease,
        ),
      ),
    );
    // color = ColorTween(
    //   begin: Colors.indigo[100],
    //   end: Colors.orange[400],
    // ).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: const Interval(
    //       0.500,
    //       0.750,
    //       curve: Curves.ease,
    //     ),
    //   ),
    // );

    animation = TimelineTween()
        // Opacity
        .addScene(
          begin: const Duration(microseconds: 0),
          end: const Duration(microseconds: 100),
          curve: Curves.ease,
        )
        // Animate the opacity property from 0 to 1 within this scene
        .animate(AnimProps.opacity, tween: Tween(begin: 0.0, end: 1.0))
        .addSubsequentScene(
          delay: const Duration(microseconds: 25),
          duration: const Duration(microseconds: 125),
          curve: Curves.ease,
        )
        .animate(AnimProps.width, tween: Tween(begin: 0.0, end: deviceWidth))
        // Height and Padding
        .addSubsequentScene(
          duration: const Duration(microseconds: 125),
          curve: Curves.ease,
        )
        .animate(AnimProps.height, tween: Tween(begin: 0.0, end: 80.0))
        .animate(
          AnimProps.padding,
          tween: EdgeInsetsTween(
            begin: const EdgeInsets.symmetric(horizontal: 20.0),
            end: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
        )
        // BorderRadius
        .addSubsequentScene(
          duration: const Duration(microseconds: 125),
          curve: Curves.ease,
        )
        .animate(
          AnimProps.borderRadius,
          tween: BorderRadiusTween(
            begin: BorderRadius.circular(deviceWidth * 0.06),
            end: BorderRadius.circular(deviceWidth * 0.06),
          ),
        )
        // // Color
        // .addSubsequentScene(
        //   duration: const Duration(microseconds: 250),
        //   curve: Curves.ease,
        // )
        // .animate(
        //   AnimProps.color,
        //   tween: ColorTween(
        //     begin: Colors.indigo[100],
        //     end: Colors.orange[400],
        //   ),
        // )
        // Get the Tween so that we can drive it with the AnimationController
        .parent
        .animate(controller);
    // animatedBy(controller);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log('width : $deviceWidth');
    return Consumer(builder: (context, watch, child) {
      final gameProvider = selectCurrentProvider(watch);
      final answerProvider = watch(answerStateProvider);
      // final widthProvider = watch(widthStateProvider);
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
                                      ? gameProvider.gameModel.remainSeconds /
                                          100
                                      : gameProvider.gameModel.remainSeconds /
                                          5,
                                  strokeWidth: 12,
                                  valueColor: AlwaysStoppedAnimation(
                                      settingsProvider.currentTheme[1]),
                                  backgroundColor:
                                      settingsProvider.currentTheme[2],
                                ),
                                Center(
                                  child: Text(
                                    '${gameProvider.gameModel.remainSeconds}',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
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
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.status ==
                                  AnimationStatus.dismissed) {
                                controller.forward();
                              } else if (controller.status ==
                                  AnimationStatus.completed) {
                                controller.reverse();
                              }
                            },
                            child: Center(
                              child: Container(
                                width: size.width,
                                height: size.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border:
                                        Border.all(color: Colors.transparent)),
                                child: AnimatedBuilder(
                                  animation: controller,
                                  builder: _buildAnimation,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.1,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 5),
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
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                Text(
                                  '${gameProvider.gameModel.secondNum}',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: size.width,
                              height: size.height * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: AnimatedBuilder(
                                animation: controller,
                                builder: _buildAnimation,
                              ),
                            ),
                          ),
                        ],
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
    });
  }

  // method to check user's answer
  void checkAnswer(T Function<T>(ProviderBase<Object?, T>) watch) async {
    final gameProvider = selectCurrentProvider(watch);
    final answerProvider = watch(answerStateProvider);
    final settingsProvider = watch(settingsChangeNotifierProvider);
    if (int.parse(answerProvider.state) == gameProvider.gameModel.trueAnswer) {
      await controller.forward();
      playCorrectAnswerSound(settingsProvider.sounds[4]);
      answerProvider.state = '';
      gameProvider.updateScore();
      gameProvider.setQuestion();
      await controller.reverse();
      if (watch(modeStateProvider).state != 2) {
        watch(timerStateProvider).state.cancel();
        questionTimer();
      }
      // if (watch(widthStateProvider).state == 1) {
      //   watch(widthStateProvider).state = 5;
      // } else {
      //   watch(widthStateProvider).state = 1;
      // }
    } else {
      answerProvider.state = '';
      endThis('Wrong Answer, try again!');
    }
    if (gameProvider.gameModel.score == 70) {
      endThis('WOWWWWW, Congratulations');
    }
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: animation.value.get(AnimProps.padding),
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: animation.value.get(AnimProps.opacity),
        child: Container(
          width: animation.value.get(AnimProps.width),
          height: animation.value.get(AnimProps.height),
          decoration: BoxDecoration(
            color: context.read(settingsChangeNotifierProvider).currentTheme[1],
            borderRadius: animation.value.get(AnimProps.borderRadius),
          ),
        ),
      ),
    );
  }
}
