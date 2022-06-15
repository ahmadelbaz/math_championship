import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/screens/game_screen.dart';

import '../functions/play_sounds.dart';

class KeyboardContainer extends ConsumerWidget {
  final VoidCallback endThis;
  // String answer;
  // int userAnswer;
  // final int trueAnswer;
  final VoidCallback checkAnswer;
  final dynamic providerMode;

  const KeyboardContainer(this.endThis, this.checkAnswer, this.providerMode,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, watch) {
    // final variable to get the device size to use it in dimensions
    final deviceSize = MediaQuery.of(context).size;
    // providers we want to use here
    // final _modeProvider = watch(providerMode);
    final _answerProvider = watch(answerStateProvider);
    final _settingsProvider = watch(settingsChangeNotifierProvider);

    // grid view values
    List<String> gridButtons = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'Clear',
      '0',
      'End',
    ];

    return SizedBox(
      width: deviceSize.width * 0.85,
      child: GridView.builder(
        itemCount: gridButtons.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {},
          child: GridTile(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                if (gridButtons[index] == 'End') {
                  // this means user wanna quit and enough with current score,
                  // so navigate him to result screen
                  // Navigate user to result screen with current score
                  endThis();
                } else if (gridButtons[index] == 'Clear') {
                  playInGameClearSound(_settingsProvider.sounds[6]);
                  log('u r in clear');
                  // This means true answer is more that 1 digit
                  //  and the user wanna clear something he wrote
                  if (_answerProvider.state.isNotEmpty) {
                    log('answer is not empty');
                    _answerProvider.state = _answerProvider.state
                        .substring(0, _answerProvider.state.length - 1);
                  }
                } else {
                  // sounds is here
                  // playInGameClickSound();
                  log('this is what u clicked ${gridButtons[index]}');
                  if (providerMode.getGame().trueAnswer < 10) {
                    _answerProvider.state = gridButtons[index];
                    checkAnswer();
                  } else if (providerMode.getGame().trueAnswer > 9 &&
                      providerMode.getGame().trueAnswer < 100) {
                    if (_answerProvider.state.isEmpty) {
                      _answerProvider.state = gridButtons[index];
                      log(_answerProvider.state);
                    } else {
                      _answerProvider.state += gridButtons[index];
                      log(_answerProvider.state);
                      checkAnswer();
                    }
                  } else if (providerMode.getGame().trueAnswer > 99 &&
                      providerMode.getGame().trueAnswer < 1000) {
                    if (_answerProvider.state.isEmpty) {
                      _answerProvider.state = gridButtons[index];
                      log(_answerProvider.state);
                    } else if (_answerProvider.state.length == 1) {
                      _answerProvider.state += gridButtons[index];
                    } else {
                      _answerProvider.state += gridButtons[index];
                      log(_answerProvider.state);
                      checkAnswer();
                    }
                  } else if (providerMode.getGame().trueAnswer > 999 &&
                      providerMode.getGame().trueAnswer < 10000) {
                    if (_answerProvider.state.isEmpty) {
                      _answerProvider.state = gridButtons[index];
                      log(_answerProvider.state);
                    } else if (_answerProvider.state.length == 1 ||
                        _answerProvider.state.length == 2) {
                      _answerProvider.state += gridButtons[index];
                    } else {
                      _answerProvider.state += gridButtons[index];
                      log(_answerProvider.state);
                      checkAnswer();
                    }
                  }
                }
              },
              child: Text(
                gridButtons[index],
                style: TextStyle(
                  color: _settingsProvider.currentTheme[0],
                ),
              ),
            ),
            // header: ,
          ),
        ),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
