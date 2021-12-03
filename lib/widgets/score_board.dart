import 'package:flutter/material.dart';

import 'coins_icon.dart';

class ScoreBoard extends StatelessWidget {
  final int mathPoints;
  final int mathCoins;

  ScoreBoard(this.mathPoints, this.mathCoins);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  const snackBar = SnackBar(
                    content: Text('Math Points'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Icon(
                  MyFlutterApp.points,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(' $mathPoints',
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  const snackBar = SnackBar(
                    content: Text('Math Coins'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Icon(
                  MyFlutterApp.coins, // point_of_sale
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                ' $mathCoins',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
