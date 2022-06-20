import 'dart:developer';

import 'package:math_championship/providers/game_provider.dart';

class RandomSignProvider extends GameProvider {
  @override
  setQuestion() {
    if (gameModel.level == 1) {
      setQestionDetails(5, generateRandomSign(), 3, 4, 1, 3);
    }
    // lvl 2 question (5 < score > 10, sign 'random')
    else if (gameModel.level == 2) {
      setQestionDetails(5, generateRandomSign(), 6, 4, 1, 3);
    }
    // lvl 3 question (10 < score > 15, sign 'random')
    else if (gameModel.level == 3) {
      setQestionDetails(5, generateRandomSign(), 6, 4, 3, 4);
    }
    // lvl 4 question (15 < score > 20, sign 'random')
    else if (gameModel.level == 4) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 1, 3);
    }
    // lvl 5 question (20 < score > 25, sign 'random')
    else if (gameModel.level == 5) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 2, 4);
    }
    // lvl 6 question (25 < score > 30, sign 'random')
    else if (gameModel.level == 6) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 6, 3);
    }
  }

  @override
  setQestionDetails(int remSeconds, String sign, int firstNumMin,
      int firstNumMax, int secondNumMin, secondNumMax) {
    setRemainingSeconds(remSeconds);
    setSign(sign);
    if (sign == '/') {
      createDivisionQs(firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    } else {
      checkRepetationAndSubmit(
          firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    }
  }

  void createDivisionQs(
      int firstNumMin, int firstNumMax, int factorNumMin, int factorNumMax) {
    int firstNum = generateRandomNum(firstNumMin, firstNumMax);
    int factorNum = generateRandomNum(factorNumMin, factorNumMax);
    int secondNum = firstNum * factorNum;
    setFirstNum(secondNum);
    setSecondNum(firstNum);
    setTrueAnswer();
    notifyListeners();
  }

  @override
  printName() {
    log('Random Sign Mode');
  }

  // void setRandomSignQuestion() {

  // }

}
