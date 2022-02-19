import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/widgets/coin_icon.dart';
import 'package:math_championship/widgets/point_icon.dart';

import '../functions/play_sounds.dart';
import '../functions/start_mode_function.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _args = ModalRoute.of(context)!.settings.arguments as List<String>;
    final _pointsProvider = context.read(pointsChangeNotifierProvider);
    _pointsProvider.updatePoints(int.parse(_args[2]));
    // close inGame provider
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      context.read(inGameStateProvider).state = false;
    });
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kMainColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _args[0] == 'Wrong Answer, try again!'
                ? Lottie.asset('assets/animations/sadrobot.json',
                    width: 200, height: 200)
                : Lottie.network(
                    _args[0] == 'You ended this, try again!'
                        ? 'https://assets10.lottiefiles.com/packages/lf20_lKvkGl.json'
                        : _args[0] == 'Time\'s Up, try again!'
                            ? 'https://assets7.lottiefiles.com/packages/lf20_LL5C7n.json'
                            : 'https://assets5.lottiefiles.com/packages/lf20_xldzoar8.json',
                    width: 200,
                    height: 200),
            SizedBox(
              height: _size.height * 0.02,
            ),
            Text(_args[0]),
            SizedBox(
              height: _size.height * 0.02,
            ),
            Text(_args[1]),
            SizedBox(
              height: _size.height * 0.04,
            ),
            Text(
              'Score : ${_args[2]}',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: _size.height * 0.02,
            ),
            Text('High Score : ${_args[3]}',
                style: Theme.of(context).textTheme.headline2),
            SizedBox(
              height: _size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   MyFlutterApp.points,
                //   color: Theme.of(context).primaryColor,
                // ),
                pointIcon(),
                Text(' +${_args[2]}',
                    style: Theme.of(context).textTheme.headline5),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   MyFlutterApp.coins, // point_of_sale
                //   color: Theme.of(context).primaryColor,
                // ),
                coinIcon(),
                Text(
                  ' +${(int.parse(_args[2]) / 5).floor()}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(
              height: _size.height * 0.04,
            ),
            Text(
              _args[4],
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: _size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(_size.width * 0.40, _size.height * 0.09),
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    startMode(context.read, context, int.parse(_args[6]));
                  },
                  child: const Text('Play again'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(_size.width * 0.40, _size.height * 0.09),
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    playGeneralClickSound();
                    Navigator.of(context).pushReplacementNamed('/start_screen');
                  },
                  child: const Text('Main menu'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
