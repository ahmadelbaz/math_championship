import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget pointIcon() {
  return Container(
    child: Lottie.asset(
      'assets/animations/point.json',
      width: 30,
      height: 30,
    ),
  );
}
