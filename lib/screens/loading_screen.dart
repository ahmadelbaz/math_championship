import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';

final timerProvider = StateProvider<int>((ref) => 3);

class LoadingScreen extends StatelessWidget {
  // LoadingScreen({Key? key}) : super(key: key);

  T Function<T>(ProviderBase<Object?, T>) watch;
  int index;

  LoadingScreen(this.watch, this.index);

  late Timer _timer;
  final int _start = 10;

  void stageTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          // setState(() {
          timer.cancel();
          // });
        } else {
          // setState(() {
          watch(timerProvider).state -= 1;
          // });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    stageTimer();
    return Scaffold(
      backgroundColor: kMainColor,
      body: Container(
        child: Center(
          child: Text('${watch(timerProvider).state}'),
        ),
      ),
    );
  }
}
