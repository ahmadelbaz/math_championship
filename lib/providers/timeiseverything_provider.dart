import 'dart:async';
import 'dart:math';

import 'dart:developer' as log;

import 'package:flutter/material.dart';
import 'package:math_championship/models/solve_game_model.dart';

class TimeIsEveryThingProvider extends ChangeNotifier {
  GameModel _gameModel = GameModel(0, 0, 0, 0, 'sign', 1, 0);
  // Timer _timer = Timer(Duration(milliseconds: 1), () {});

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
    }
    // else if(_gameModel.sign == '/'){
    //   _trueAnswer = _gameModel.firstNum / _gameModel.secondNum;
    // }
    _gameModel = GameModel(
        _gameModel.firstNum,
        _gameModel.secondNum,
        _trueAnswer,
        _gameModel.remainSeconds,
        _gameModel.sign,
        _gameModel.level,
        _gameModel.score);
    notifyListeners();
    log.log('this is true answer HERE ${_gameModel.trueAnswer}');
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
    if (_gameModel.score < 5) {
      setLevel(1);
    } else if (_gameModel.score < 10 && _gameModel.score > 4) {
      setLevel(2);
    } else if (_gameModel.score < 15 && _gameModel.score > 9) {
      setLevel(3);
    } else if (_gameModel.score < 20 && _gameModel.score > 14) {
      setLevel(4);
    } else if (_gameModel.score < 25 && _gameModel.score > 19) {
      setLevel(5);
    } else if (_gameModel.score < 30 && _gameModel.score > 24) {
      setLevel(6);
    } else if (_gameModel.score < 35 && _gameModel.score > 29) {
      setLevel(7);
    } else if (_gameModel.score < 40 && _gameModel.score > 34) {
      setLevel(8);
    } else if (_gameModel.score < 45 && _gameModel.score > 39) {
      setLevel(9);
    } else if (_gameModel.score < 50 && _gameModel.score > 44) {
      setLevel(10);
    } else if (_gameModel.score < 55 && _gameModel.score > 49) {
      setLevel(11);
    } else if (_gameModel.score < 60 && _gameModel.score > 45) {
      setLevel(12);
    } else if (_gameModel.score < 65 && _gameModel.score > 59) {
      setLevel(13);
    } else if (_gameModel.score < 70 && _gameModel.score > 64) {
      setLevel(14);
    } else if (_gameModel.score == 70) {
      youAreWinner();
    }
    notifyListeners();
  }

  // void checkAnswer(int answer) {
  //   if (answer == _gameModel.trueAnswer) {
  //     log.log('true answer !');
  //     updateScore();
  //     setQuestion();
  //     // return true;
  //   } else {
  //     setRemainingSeconds(0);
  //     log.log('Wrong answer !');
  //     // return false;
  //   }
  // }

  void setQuestion() {
    // lvl 1 question (score > 5, sign '+')
    if (_gameModel.level == 1) {
      setQestionDetails('+', 1, 4, 1, 4);
    }
    // lvl 2 question (5 < score > 10, sign '+')
    else if (_gameModel.level == 2) {
      setQestionDetails('+', 5, 4, 1, 4);
    }
    // lvl 3 question (10 < score > 15, sign 'X')
    else if (_gameModel.level == 3) {
      setQestionDetails('X', 1, 4, 1, 4);
    }
    // lvl 4 question (15 < score > 20, sign '-')
    else if (_gameModel.level == 4) {
      setQestionDetails('-', 5, 4, 1, 4);
    }
    // lvl 5 question (20 < score > 25, sign '+')
    else if (_gameModel.level == 5) {
      setQestionDetails('+', 5, 4, 5, 4);
    }
    // lvl 6 question (25 < score > 30, sign '+')
    else if (_gameModel.level == 6) {
      setQestionDetails('+', 10, 9, 1, 9);
    }
    // lvl 7 question (30 < score > 35, sign '+')
    else if (_gameModel.level == 7) {
      setQestionDetails('+', 10, 9, 10, 9);
    }
    // lvl 8 question (35 < score > 40, sign '+')
    else if (_gameModel.level == 8) {
      setQestionDetails('+', 1, 19, 20, 79);
    }
    // lvl 9 question (40 < score > 45, sign '-')
    else if (_gameModel.level == 9) {
      setQestionDetails('-', 20, 79, 1, 19);
    }
    // lvl 10 question (45 < score > 50, sign '+')
    else if (_gameModel.level == 10) {
      setQestionDetails('+', 20, 79, 20, 79);
    }
    // lvl 11 question (50 < score > 55, sign '+')
    else if (_gameModel.level == 11) {
      setQestionDetails('+', 20, 79, 100, 899);
    }
    // lvl 12 question (55 < score > 60, sign '+')
    else if (_gameModel.level == 12) {
      setQestionDetails('+', 100, 899, 100, 899);
    }
    // lvl 13 question (60 < score > 65, sign '-')
    else if (_gameModel.level == 13) {
      setQestionDetails('-', 100, 899, 20, 79);
    }
    // lvl 14 question (65 < score > 70, sign '-')
    else if (_gameModel.level == 14) {
      setQestionDetails('-', 500, 899, 100, 399);
    }
  }

  // method gets details of the question and set the values in their functions
  void setQestionDetails(String sign, int firstNumMin, int firstNumMax,
      int secondNumMin, secondNumMax) {
    // in this mode we want just time in the beginning not every question
    if (_gameModel.score == 0) {
      setRemainingSeconds(30);
    }
    setSign(sign);
    setFirstNum(generateRandomNum(firstNumMin, firstNumMax));
    setSecondNum(generateRandomNum(secondNumMin, secondNumMax));
    setTrueAnswer();
    notifyListeners();
  }

  int generateRandomNum(int min, int max) {
    Random r = Random();
    return min + r.nextInt(max);
  }

  void youAreWinner() {}
}
