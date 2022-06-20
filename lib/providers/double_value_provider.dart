import 'dart:developer';

import 'game_provider.dart';

class DoubleValueProvider extends GameProvider {
  @override
  setQestionDetails(int remSeconds, String sign, int firstNumMin,
      int firstNumMax, int secondNumMin, secondNumMax) {
    setRemainingSeconds(remSeconds);
    setSign('X');
    setFirstAndSecondNums(firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    setTrueAnswer();
    notifyListeners();
  }

  @override
  setQuestion() {
    if (gameModel.level == 1) {
      setQestionDetails(5, 'X', 1, 9, 2, 1);
    }
    // lvl 2 question (5 < score > 10, sign 'X')
    else if (gameModel.level == 2) {
      setQestionDetails(5, 'X', 5, 15, 2, 1);
    }
    // lvl 3 question (10 < score > 15, sign 'X')
    else if (gameModel.level == 3) {
      setQestionDetails(5, 'X', 10, 10, 2, 1);
    }
    // lvl 4 question (15 < score > 20, sign 'X')
    else if (gameModel.level == 4) {
      setQestionDetails(5, 'X', 10, 30, 2, 1);
    }
    // lvl 5 question (20 < score > 25, sign 'X')
    else if (gameModel.level == 5) {
      setQestionDetails(5, 'X', 20, 20, 2, 1);
    }
    // lvl 6 question (25 < score > 30, sign 'X')
    else if (gameModel.level == 6) {
      setQestionDetails(5, 'X', 30, 30, 2, 1);
    }
    notifyListeners();
  }

  @override
  printName() {
    log('Double Value Mode');
  }
}
