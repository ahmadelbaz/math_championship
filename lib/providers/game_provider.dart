import 'dart:math';

import 'dart:developer' as log;

import 'package:flutter/material.dart';
import 'package:math_championship/models/game_model.dart';

class SolveProvider extends ChangeNotifier {
  GameModel _gameModel = GameModel(0, 0, 0, 0, 'sign', 1, 0);

  int _lastFirst = 0, _lastSecond = 0;

  // variable to know which game mode are we in now
  int _gameMode = 0;

  void setGameMode(int mode) {
    _gameMode = mode;
  }

  int getGameMode() {
    return _gameMode;
  }

  GameModel getGame() {
    return _gameModel;
  }

  void resetGame() {
    _gameModel = GameModel(0, 0, 0, 0, 'sign', 1, 0);
    notifyListeners();
  }

  void setRemainingSeconds(int sec) {
    _gameModel = GameModel(
        _gameModel.firstNum,
        _gameModel.secondNum,
        _gameModel.trueAnswer,
        sec,
        _gameModel.sign,
        _gameModel.level,
        _gameModel.score);
    notifyListeners();
  }

  void setFirstNum(int num) {
    _gameModel = GameModel(
        num,
        _gameModel.secondNum,
        _gameModel.trueAnswer,
        _gameModel.remainSeconds,
        _gameModel.sign,
        _gameModel.level,
        _gameModel.score);
    notifyListeners();
  }

  void setSecondNum(int num) {
    _gameModel = GameModel(
        _gameModel.firstNum,
        num,
        _gameModel.trueAnswer,
        _gameModel.remainSeconds,
        _gameModel.sign,
        _gameModel.level,
        _gameModel.score);
    notifyListeners();
  }

  void setTrueAnswer() {
    int _trueAnswer = 0;
    if (_gameModel.sign == '+') {
      _trueAnswer = _gameModel.firstNum + _gameModel.secondNum;
    } else if (_gameModel.sign == '-') {
      _trueAnswer = _gameModel.firstNum - _gameModel.secondNum;
    } else if (_gameModel.sign == 'X') {
      _trueAnswer = _gameModel.firstNum * _gameModel.secondNum;
    } else if (_gameModel.sign == '/') {
      _trueAnswer = _gameModel.firstNum ~/ _gameModel.secondNum;
    }
    _gameModel = GameModel(
        _gameModel.firstNum,
        _gameModel.secondNum,
        _trueAnswer,
        _gameModel.remainSeconds,
        _gameModel.sign,
        _gameModel.level,
        _gameModel.score);
    notifyListeners();
  }

  void setSign(String sign) {
    _gameModel = GameModel(
        _gameModel.firstNum,
        _gameModel.secondNum,
        _gameModel.trueAnswer,
        _gameModel.remainSeconds,
        sign,
        _gameModel.level,
        _gameModel.score);
    notifyListeners();
  }

  void updateScore() {
    _gameModel = GameModel(
        _gameModel.firstNum,
        _gameModel.secondNum,
        _gameModel.trueAnswer,
        _gameModel.remainSeconds,
        _gameModel.sign,
        _gameModel.level,
        _gameModel.score + 1);
    updateLevel();
    notifyListeners();
  }

  void setLevel(int lvl) {
    _gameModel = GameModel(
        _gameModel.firstNum,
        _gameModel.secondNum,
        _gameModel.trueAnswer,
        _gameModel.remainSeconds,
        _gameModel.sign,
        lvl,
        _gameModel.score);
    notifyListeners();
  }

  void updateLevel() {
    // from 1 --> 4 = lvl 1, from 5 --> 9 = lvl 2 etc.
    setLevel((_gameModel.score / 5).floor() + 1);
    if (_gameModel.score == 70) {
      youAreWinner();
    }
    notifyListeners();
  }

  void setQuestion() {
    // If 'Random Sign' mode
    if (_gameMode == 2) {
      setRandomSignQuestion();
      // other modes (until now)
    } else {
      setSolveQuestion();
    }
  }

  void setSolveQuestion() {
    // lvl 1 question (score > 5, sign '+')
    if (_gameModel.level == 1) {
      setQestionDetails(5, '+', 1, 4, 1, 4);
    }
    // lvl 2 question (5 < score > 10, sign '+')
    else if (_gameModel.level == 2) {
      setQestionDetails(5, '+', 5, 4, 1, 4);
    }
    // lvl 3 question (10 < score > 15, sign 'X')
    else if (_gameModel.level == 3) {
      setQestionDetails(5, 'X', 1, 4, 1, 4);
    }
    // lvl 4 question (15 < score > 20, sign '-')
    else if (_gameModel.level == 4) {
      setQestionDetails(5, '-', 5, 4, 1, 4);
    }
    // lvl 5 question (20 < score > 25, sign '+')
    else if (_gameModel.level == 5) {
      setQestionDetails(5, '+', 5, 4, 5, 4);
    }
    // lvl 6 question (25 < score > 30, sign '+')
    else if (_gameModel.level == 6) {
      setQestionDetails(5, '+', 10, 9, 1, 9);
    }
    // lvl 7 question (30 < score > 35, sign '+')
    else if (_gameModel.level == 7) {
      setQestionDetails(5, '+', 10, 9, 10, 9);
    }
    // lvl 8 question (35 < score > 40, sign '+')
    else if (_gameModel.level == 8) {
      setQestionDetails(5, '+', 1, 19, 20, 79);
    }
    // lvl 9 question (40 < score > 45, sign '-')
    else if (_gameModel.level == 9) {
      setQestionDetails(5, '-', 20, 79, 1, 19);
    }
    // lvl 10 question (45 < score > 50, sign '+')
    else if (_gameModel.level == 10) {
      setQestionDetails(5, '+', 20, 79, 20, 79);
    }
    // lvl 11 question (50 < score > 55, sign '+')
    else if (_gameModel.level == 11) {
      setQestionDetails(5, '+', 20, 79, 100, 899);
    }
    // lvl 12 question (55 < score > 60, sign '+')
    else if (_gameModel.level == 12) {
      setQestionDetails(5, '+', 100, 899, 100, 899);
    }
    // lvl 13 question (60 < score > 65, sign '-')
    else if (_gameModel.level == 13) {
      setQestionDetails(5, '-', 100, 899, 20, 79);
    }
    // lvl 14 question (65 < score > 70, sign '-')
    else if (_gameModel.level == 14) {
      setQestionDetails(5, '-', 500, 899, 100, 399);
    }
  }

  // method to setQuestion for 'Random Sign' mode
  void setRandomSignQuestion() {
    if (_gameModel.level == 1) {
      // First question (special case) (score = 0, sign 'random')
      if (_gameModel.score == 0) {
        setQestionDetails(8, generateRandomSign(), 3, 4, 1, 3);
      } else {
        // setQestionDetails(5, generateRandomSign(), 3, 4, 1, 3);
        createDivisionQs();
      }
    }
    // lvl 2 question (5 < score > 10, sign 'random')
    else if (_gameModel.level == 2) {
      setQestionDetails(5, generateRandomSign(), 6, 4, 1, 3);
    }
    // lvl 3 question (10 < score > 15, sign 'random')
    else if (_gameModel.level == 3) {
      setQestionDetails(5, generateRandomSign(), 6, 4, 3, 4);
    }
    // lvl 4 question (15 < score > 20, sign 'random')
    else if (_gameModel.level == 4) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 1, 3);
    }
    // lvl 5 question (20 < score > 25, sign 'random')
    else if (_gameModel.level == 5) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 3, 4);
    }
    // lvl 6 question (25 < score > 30, sign 'random')
    else if (_gameModel.level == 6) {
      setQestionDetails(5, generateRandomSign(), 9, 4, 6, 3);
    }
  }

  // method gets details of the question and set the values in their functions
  void setQestionDetails(int remSeconds, String sign, int firstNumMin,
      int firstNumMax, int secondNumMin, secondNumMax) {
    // For another modes
    if (_gameMode == 5) {
      // setRemainingSeconds(remSeconds);
      // setSign(generateRandomSign());
      // checkRepetationAndSubmit(4, 9, 1, 4);
    } else {
      // For 'Solve' mode
      if (_gameMode == 0 || _gameMode == 2) {
        setRemainingSeconds(remSeconds);
        // For 'TimeIsEverything' mode
      } else if (_gameMode == 1) {
        if (_gameModel.score == 0) {
          setRemainingSeconds(30);
        }
      }
      setSign(sign);
      checkRepetationAndSubmit(
          firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    }
  }

  int generateRandomNum(int min, int max) {
    Random r = Random();
    return min + r.nextInt(max);
  }

  // method to generate random sign
  String generateRandomSign() {
    List<String> signs = ['+', '-', 'X', '/'];
    return signs[generateRandomNum(0, 3)];
  }

  // method to check repetation and submit the question
  void checkRepetationAndSubmit(
      int firstNumMin, int firstNumMax, int secondNumMin, int secondNumMax) {
    // set first and second nums
    setFirstAndSecondNums(firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    if (_gameModel.firstNum == _lastFirst ||
        _gameModel.firstNum == _lastSecond &&
            _gameModel.secondNum == _lastFirst ||
        _gameModel.secondNum == _lastSecond) {
      log.log('REPETATION!');
      // there is a repetation so set new numbers
      setFirstAndSecondNums(
          firstNumMin, firstNumMax, secondNumMin, secondNumMax);
      checkRepetationAndSubmit(
          firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    } else {
      // no repetation so submit the question
      _lastFirst = _gameModel.firstNum;
      _lastSecond = _gameModel.secondNum;
      setTrueAnswer();
      notifyListeners();
    }
  }

  // method to set first and second nums
  void setFirstAndSecondNums(
      int firstNumMin, int firstNumMax, int secondNumMin, int secondNumMax) {
    setFirstNum(generateRandomNum(firstNumMin, firstNumMax));
    setSecondNum(generateRandomNum(secondNumMin, secondNumMax));
  }

  void createDivisionQs() {
    int firstNum = generateRandomNum(1, 5);
    int factorNum = generateRandomNum(2, 5);
    int secondNum = firstNum * factorNum;
    setRemainingSeconds(5);
    setFirstNum(secondNum);
    setSecondNum(firstNum);
    setSign('/');
    setTrueAnswer();
    log.log('first num = $firstNum');
    log.log('factor num = $factorNum');
    log.log('second num = $secondNum');
    notifyListeners();
  }

  void youAreWinner() {}
}
