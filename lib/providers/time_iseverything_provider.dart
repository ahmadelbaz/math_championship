import 'package:math_championship/providers/game_provider.dart';

import '../functions/randoms.dart';

class TimeIsEverythingProvider extends GameProvider {
  @override
  setQestionDetails(int remSeconds, String sign, int firstNumMin,
      int firstNumMax, int secondNumMin, secondNumMax) {
    if (gameModel.score == 0) {
      setRemainingSeconds(100);
    }
    setSign(sign);
    if (sign == '/') {
      createDivisionQs(firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    } else if (sign == '+' && gameModel.level > 1) {
      checkRepetationAndSubmit(
          (firstNumMin * gameModel.level) ~/ 2,
          (firstNumMax * gameModel.level) ~/ 2,
          (secondNumMin * gameModel.level) ~/ 2,
          (secondNumMax * gameModel.level) ~/ 2);
    } else {
      checkRepetationAndSubmit(
          firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    }
    notifyListeners();
  }

  void createDivisionQs(
      int firstNumMin, int firstNumMax, int factorNumMin, int factorNumMax) {
    int firstNum = generateRandomNum(firstNumMin, firstNumMax);
    int factorNum = generateRandomNum(factorNumMin, factorNumMax);
    int secondNum = firstNum * factorNum;
    setFirstNum(secondNum);
    setSecondNum(firstNum);
    setTrueAnswer();
  }

  @override
  setQuestion() {
    if (gameModel.level == 1) {
      setQestionDetails(5, generateRandomSign(), 3, 4, 1, 3); // (3/6 - 1/3)
    }
    // lvl 2 question (5 < score < 10, sign 'random')
    else if (gameModel.level == 2) {
      setQestionDetails(5, generateRandomSign(), 6, 4, 1, 3); // (6/9 - 1/3)
    }
    // lvl 3 question (10 < score < 15, sign 'random')
    else if (gameModel.level == 3) {
      setQestionDetails(5, generateRandomSign(), 6, 4, 3, 4); // (6/9 - 3/6)
    }
    // lvl 4 question (15 < score < 20, sign 'random')
    else if (gameModel.level == 4) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 1, 3); // (9/12 - 1/3)
    }
    // lvl 5 question (20 < score < 25, sign 'random')18, 8, 2, 6  (18/25 - 2/6)
    else if (gameModel.level == 5) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 3, 4); // (9/12 - 2/5)
    }
    // lvl 6 question (25 < score < 30, sign 'random')
    else if (gameModel.level == 6) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 6, 3); // (9/12 - 6/8)
    }
    // lvl 7 question (30 < score < 35, sign 'random')
    else if (gameModel.level == 7) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 8, 3); // (9/12 - 8/10)
    }
    // lvl 8 question (35 < score < 40, sign 'random')
    else if (gameModel.level == 8) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 9, 4); // (9/12 - 9/12)
    }
  }
}
