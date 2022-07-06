import 'package:flutter/material.dart';

Widget CustomColorStack(List<Color> colors) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: colors[0], width: 20),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        width: 60,
        height: 60,
        // color: _settingsProvider.themes[index]![0],
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: colors[1], width: 20),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: 30,
        height: 30,
        // color: _settingsProvider.themes[index]![1],
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: colors[2], width: 10),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        width: 15,
        height: 15,
        // color: _settingsProvider.themes[index]![2],
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: colors[3], width: 4),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        width: 7.5,
        height: 7.5,
        // color: _settingsProvider.themes[index]![3],
      ),
    ],
  );
}
