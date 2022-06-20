import 'dart:developer';

import 'package:math_championship/providers/game_provider.dart';

class SolveProvider extends GameProvider {
  // GameModel gameModel = GameModel(0, 0, 0, 0, 'sign', 1, 0);

  // int lastFirst = 0, lastSecond = 0;

  // variable to know which game mode are we in now
  // int gameMode = 0;

  // @override
  // void setGameMode(int mode) {
  //   gameMode = mode;
  // }

  // @override
  // int getGameMode() {
  //   return gameMode;
  // }

  // @override
  // GameModel gameModel {
  //   return gameModel;
  // }

  // @override
  // void resetGame() {
  //   gameModel = GameModel(0, 0, 0, 0, 'sign', 1, 0);
  //   notifyListeners();
  // }

  // @override
  // void setRemainingSeconds(int sec) {
  //   gameModel.remainSeconds = sec;
  //   notifyListeners();
  // }

  // void setFirstNum(int num) {
  //   gameModel.firstNum = num;
  //   notifyListeners();
  // }

  // void setSecondNum(int num)
  // {
  //   gameModel.secondNum = num;
  //   notifyListeners();
  // }

  // void setTrueAnswer() {
  //   int _trueAnswer = 0;
  //   if (gameModel.sign == '+') {
  //     _trueAnswer = gameModel.firstNum + gameModel.secondNum;
  //   } else if (gameModel.sign == '-') {
  //     _trueAnswer = gameModel.firstNum - gameModel.secondNum;
  //   } else if (gameModel.sign == 'X') {
  //     _trueAnswer = gameModel.firstNum * gameModel.secondNum;
  //   } else if (gameModel.sign == '/') {
  //     _trueAnswer = gameModel.firstNum ~/ gameModel.secondNum;
  //   }
  //   gameModel.trueAnswer = _trueAnswer;
  //   notifyListeners();
  // }

  // void setSign(String sign) {
  //   gameModel.sign = sign;
  //   notifyListeners();
  // }

  // void updateScore() {
  //   gameModel.score + 1;
  //   updateLevel();
  //   notifyListeners();
  // }

  // void setLevel(int lvl) {
  //   gameModel.level = lvl;
  //   notifyListeners();
  // }

  // void updateLevel() {
  //   // from 1 --> 4 = lvl 1, from 5 --> 9 = lvl 2 etc.
  //   setLevel((gameModel.score / 5).floor() + 1);
  //   if (gameModel.score == 70) {
  //     youAreWinner();
  //   }
  //   notifyListeners();
  // }

  // void setQuestion() {
  //   // If 'Random Sign' mode
  //   if (gameMode == 2) {
  //     setRandomSignQuestion();
  //     // other modes (until now)
  //   } else if (gameMode == 3) {
  //     setDoubleValueQuestion();
  //   } else {
  //     _setSolveQuestion();
  //   }
  // }

  @override
  void setQuestion() {
    log('We are in solve provider');
    // lvl 1 question (score > 5, sign '+')
    if (gameModel.level == 1) {
      setQestionDetails(5, '+', 1, 4, 1, 4);
    }
    // lvl 2 question (5 < score > 10, sign '+')
    else if (gameModel.level == 2) {
      setQestionDetails(5, '+', 5, 4, 1, 4);
    }
    // lvl 3 question (10 < score > 15, sign 'X')
    else if (gameModel.level == 3) {
      setQestionDetails(5, 'X', 1, 4, 1, 4);
    }
    // lvl 4 question (15 < score > 20, sign '-')
    else if (gameModel.level == 4) {
      setQestionDetails(5, '-', 5, 4, 1, 4);
    }
    // lvl 5 question (20 < score > 25, sign '+')
    else if (gameModel.level == 5) {
      setQestionDetails(5, '+', 5, 4, 5, 4);
    }
    // lvl 6 question (25 < score > 30, sign '+')
    else if (gameModel.level == 6) {
      setQestionDetails(5, '+', 10, 9, 1, 9);
    }
    // lvl 7 question (30 < score > 35, sign '+')
    else if (gameModel.level == 7) {
      setQestionDetails(5, '+', 10, 9, 10, 9);
    }
    // lvl 8 question (35 < score > 40, sign '+')
    else if (gameModel.level == 8) {
      setQestionDetails(5, '+', 1, 19, 20, 79);
    }
    // lvl 9 question (40 < score > 45, sign '-')
    else if (gameModel.level == 9) {
      setQestionDetails(5, '-', 20, 79, 1, 19);
    }
    // lvl 10 question (45 < score > 50, sign '+')
    else if (gameModel.level == 10) {
      setQestionDetails(5, '+', 20, 79, 20, 79);
    }
    // lvl 11 question (50 < score > 55, sign '+')
    else if (gameModel.level == 11) {
      setQestionDetails(5, '+', 20, 79, 100, 899);
    }
    // lvl 12 question (55 < score > 60, sign '+')
    else if (gameModel.level == 12) {
      setQestionDetails(5, '+', 100, 899, 100, 899);
    }
    // lvl 13 question (60 < score > 65, sign '-')
    else if (gameModel.level == 13) {
      setQestionDetails(5, '-', 100, 899, 20, 79);
    }
    // lvl 14 question (65 < score > 70, sign '-')
    else if (gameModel.level == 14) {
      setQestionDetails(5, '-', 500, 899, 100, 399);
    }
  }

  // method to setQuestion for 'Random Sign' mode
  // void setRandomSignQuestion() {
  //   if (gameModel.level == 1) {
  //     setQestionDetails(5, generateRandomSign(), 3, 4, 1, 3);
  //   }
  //   // lvl 2 question (5 < score > 10, sign 'random')
  //   else if (gameModel.level == 2) {
  //     setQestionDetails(5, generateRandomSign(), 6, 4, 1, 3);
  //   }
  //   // lvl 3 question (10 < score > 15, sign 'random')
  //   else if (gameModel.level == 3) {
  //     setQestionDetails(5, generateRandomSign(), 6, 4, 3, 4);
  //   }
  //   // lvl 4 question (15 < score > 20, sign 'random')
  //   else if (gameModel.level == 4) {
  //     setQestionDetails(5, generateRandomSign(), 9, 4, 1, 3);
  //   }
  //   // lvl 5 question (20 < score > 25, sign 'random')
  //   else if (gameModel.level == 5) {
  //     setQestionDetails(5, generateRandomSign(), 9, 4, 2, 4);
  //   }
  //   // lvl 6 question (25 < score > 30, sign 'random')
  //   else if (gameModel.level == 6) {
  //     setQestionDetails(5, generateRandomSign(), 9, 4, 6, 3);
  //   }
  // }

  // method gets details of the question and set the values in their functions
  @override
  void setQestionDetails(int remSeconds, String sign, int firstNumMin,
      int firstNumMax, int secondNumMin, secondNumMax) {
    setRemainingSeconds(remSeconds);
    setSign(sign);
    checkRepetationAndSubmit(
        firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    notifyListeners();
    // if (gameMode == 2) {
    //   setRemainingSeconds(remSeconds);
    //   setSign(sign);
    //   if (sign == '/') {
    //     createDivisionQs(firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    //   } else {
    //     checkRepetationAndSubmit(
    //         firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    //   }
    // }
    // For another modes
    // if (gameMode == 3) {
    // setRemainingSeconds(remSeconds);
    // setSign('X');
    // setFirstAndSecondNums(
    //     firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    // setTrueAnswer();
    // } else {
    //   // For 'Solve' mode
    //   if (gameMode == 0) {
    //     // For 'TimeIsEverything' mode
    //   } else if (gameMode == 1) {
    //     if (gameModel.score == 0) {
    //       setRemainingSeconds(30);
    //     }
    //   }
    // }
  }

  // int generateRandomNum(int min, int max) {
  //   Random r = Random();
  //   return min + r.nextInt(max);
  // }

  // // method to generate random sign
  // String generateRandomSign() {
  //   List<String> signs = ['+', '-', 'X', '/'];
  //   return signs[generateRandomNum(0, 4)];
  // }

  // // method to check repetation and submit the question
  // void checkRepetationAndSubmit(
  //     int firstNumMin, int firstNumMax, int secondNumMin, int secondNumMax) {
  //   // set first and second nums
  //   setFirstAndSecondNums(firstNumMin, firstNumMax, secondNumMin, secondNumMax);
  //   if (gameModel.firstNum == lastFirst ||
  //       gameModel.firstNum == lastSecond && gameModel.secondNum == lastFirst ||
  //       gameModel.secondNum == lastSecond) {
  //     log.log('REPETATION!');
  //     // there is a repetation so set new numbers
  //     setFirstAndSecondNums(
  //         firstNumMin, firstNumMax, secondNumMin, secondNumMax);
  //     checkRepetationAndSubmit(
  //         firstNumMin, firstNumMax, secondNumMin, secondNumMax);
  //   } else {
  //     // no repetation so submit the question
  //     lastFirst = gameModel.firstNum;
  //     lastSecond = gameModel.secondNum;
  //     setTrueAnswer();
  //     notifyListeners();
  //   }
  // }

  // method to set first and second nums
  // void setFirstAndSecondNums(
  //     int firstNumMin, int firstNumMax, int secondNumMin, int secondNumMax) {
  //   setFirstNum(generateRandomNum(firstNumMin, firstNumMax));
  //   setSecondNum(generateRandomNum(secondNumMin, secondNumMax));
  // }

  // void createDivisionQs(
  //     int firstNumMin, int firstNumMax, int factorNumMin, int factorNumMax) {
  //   int firstNum = generateRandomNum(firstNumMin, firstNumMax);
  //   int factorNum = generateRandomNum(factorNumMin, factorNumMax);
  //   int secondNum = firstNum * factorNum;
  //   setFirstNum(secondNum);
  //   setSecondNum(firstNum);
  //   setTrueAnswer();
  //   notifyListeners();
  // }

  // setDoubleValueQuestion() {
  //   if (gameModel.level == 1) {
  //     setQestionDetails(5, 'X', 1, 9, 2, 1);
  //   }
  //   // lvl 2 question (5 < score > 10, sign 'X')
  //   else if (gameModel.level == 2) {
  //     setQestionDetails(5, 'X', 5, 15, 2, 1);
  //   }
  //   // lvl 3 question (10 < score > 15, sign 'X')
  //   else if (gameModel.level == 3) {
  //     setQestionDetails(5, 'X', 10, 10, 2, 1);
  //   }
  //   // lvl 4 question (15 < score > 20, sign 'X')
  //   else if (gameModel.level == 4) {
  //     setQestionDetails(5, 'X', 10, 30, 2, 1);
  //   }
  //   // lvl 5 question (20 < score > 25, sign 'X')
  //   else if (gameModel.level == 5) {
  //     setQestionDetails(5, 'X', 20, 20, 2, 1);
  //   }
  //   // lvl 6 question (25 < score > 30, sign 'X')
  //   else if (gameModel.level == 6) {
  //     setQestionDetails(5, 'X', 30, 30, 2, 1);
  //   }
  //   notifyListeners();
  // }

  // void youAreWinner() {}
  @override
  printName() {
    log('Solve Mode');
  }
}
