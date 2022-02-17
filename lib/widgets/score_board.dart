import 'package:flutter/material.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';

import '../functions/play_sounds.dart';
import 'coin_icon.dart';
import 'point_icon.dart';

class ScoreBoard extends StatelessWidget {
  final int mathPoints;
  final int mathCoins;

  const ScoreBoard(this.mathPoints, this.mathCoins, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              playSnackBarClickSound();
              customSnackBar('Math Points');
            },
            child: Row(
              children: [
                // Icon(
                //   MyFlutterApp.points,
                //   color: Theme.of(context).primaryColor,
                // ),
                pointIcon(),
                Text(' $mathPoints',
                    style: Theme.of(context).textTheme.headline5),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              playSnackBarClickSound();
              customSnackBar('Math Coins');
            },
            child: Row(
              children: [
                // Icon(
                //   MyFlutterApp.coins, // point_of_sale
                //   color: Theme.of(context).primaryColor,
                // ),
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
