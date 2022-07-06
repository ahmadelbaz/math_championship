import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';

import '../functions/play_sounds.dart';
import '../main.dart';
import 'coin_icon.dart';
import 'point_icon.dart';

class ScoreBoard extends StatelessWidget {
  final int mathPoints;
  final int mathCoins;

  const ScoreBoard(this.mathPoints, this.mathCoins, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _settingsProvider = context.read(settingsChangeNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              playScoreBoardSound(_settingsProvider.sounds[3]);
              customSnackBar('Math Points');
            },
            child: Row(
              children: [
                pointIcon(),
                Text(' $mathPoints',
                    style: Theme.of(context).textTheme.headline5),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              playScoreBoardSound(_settingsProvider.sounds[3]);
              customSnackBar('Math Coins');
            },
            child: Row(
              children: [
                coinIcon(),
                Text(
                  ' $mathCoins',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
