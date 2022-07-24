import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/widgets/coin_icon.dart';
import 'package:math_championship/widgets/point_icon.dart';

import '../functions/play_sounds.dart';
import '../functions/start_mode_function.dart';
import '../main.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    final pointsProvider = context.read(pointsChangeNotifierProvider);
    final settingsProvider = context.read(settingsChangeNotifierProvider);
    final achievementProvider =
        context.read(achievementsChangeNotifierProvider);
    pointsProvider.updatePoints(int.parse(args[2]));
    // close inGame provider
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      context.read(inGameStateProvider).state = false;
      // achievement : break your high score
      if (int.parse(args[2]) > int.parse(args[3]) && int.parse(args[3]) > 0) {
        achievementProvider.checkAchievement(
            9, context.read(pointsChangeNotifierProvider));
      }
      // achievement : Score 10 Math Points
      if (int.parse(args[2]) >= 10) {
        achievementProvider.checkAchievement(
            7, context.read(pointsChangeNotifierProvider));
      }
      // achievement : Score 50 Math Points
      if (int.parse(args[2]) >= 50) {
        achievementProvider.checkAchievement(
            8, context.read(pointsChangeNotifierProvider));
      }
      // achievement : Win one game
      if (int.parse(args[2]) >= 70) {
        achievementProvider.checkAchievement(
            10, context.read(pointsChangeNotifierProvider));
      }
    });
    return Scaffold(
      backgroundColor: settingsProvider.currentTheme[0],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            args[0] == 'Wrong Answer, try again!'
                ? Lottie.asset(wrongAnswerAnimation,
                    width: size.width * 0.56, height: size.height * 0.25)
                : Lottie.asset(
                    args[0] == 'You ended this, try again!'
                        ? youEndedThisAnimation
                        : args[0] == 'Time\'s Up, try again!'
                            ? timeIsUpAnimation
                            : congratsAnimation,
                    width: 200,
                    height: 200),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              args[0],
              style: TextStyle(
                  fontSize: 18, color: settingsProvider.currentTheme[1]),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FittedBox(
                child: Text(
                  args[1],
                  style: TextStyle(
                      fontSize: 18, color: settingsProvider.currentTheme[1]),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Text(
              'Score : ${args[2]}',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text('High Score : ${args[3]}',
                style: Theme.of(context).textTheme.headline2),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pointIcon(),
                Text(' +${args[2]}',
                    style: Theme.of(context).textTheme.headline5),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                coinIcon(),
                Text(
                  ' +${(int.parse(args[2]) / 5).floor()}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  args[4],
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  args[5],
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  args[6],
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '=',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  args[7],
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            // Text(
            //   args[4],
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width * 0.40, size.height * 0.09),
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    startMode(context.read, context, int.parse(args[9]));
                  },
                  child: Text(
                    'Play again',
                    style: TextStyle(
                      color: settingsProvider.currentTheme[0],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width * 0.40, size.height * 0.09),
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    playGeneralSound(settingsProvider.sounds[1]);
                    Navigator.of(context).pushReplacementNamed('/start_screen');
                  },
                  child: Text(
                    'Main menu',
                    style: TextStyle(
                      color: settingsProvider.currentTheme[0],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
