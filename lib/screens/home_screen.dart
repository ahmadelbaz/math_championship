import 'package:flutter/material.dart';
import 'package:math_championship/widgets/score_board.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // ScoreBoard(),
          Expanded(
              child: ListView(
            children: [
              SizedBox(
                height: _size.height * 0.25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                  child: const Text('Start'),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
