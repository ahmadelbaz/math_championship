import 'package:flutter/material.dart';

import '../functions/randoms.dart';
import '../models/game_model.dart';
// TODO :
// Methods that dont use any data here and can be separated in external fiel
// Separate it and call it here

// we think that maybe this can be an extract class
abstract class GameProvider extends ChangeNotifier {
  GameModel _gameModel = GameModel(0, 0, 0, 0, 'sign', 1, 0);
  GameModel get gameModel => _gameModel;
  int? _lastFirst, _lastSecond;
  int? get lastFirst => _lastFirst;
  int? get lastSecond => _lastSecond;

  resetGame() {
    _gameModel = GameModel(0, 0, 0, 0, 'sign', 1, 0);
    notifyListeners();
  }

  setRemainingSeconds(int sec) {
    _gameModel.remainSeconds = sec;
    notifyListeners();
  }

  setFirstNum(int num) {
    _gameModel.firstNum = num;
    notifyListeners();
  }

  setSecondNum(int num) {
    _gameModel.secondNum = num;
    notifyListeners();
  }

  // set true answer based on current data(first num, sign etc)
  void setTrueAnswer() {
    int trueAnswer = 0;
    if (_gameModel.sign == '+') {
      trueAnswer = _gameModel.firstNum + _gameModel.secondNum;
    } else if (_gameModel.sign == '-') {
      trueAnswer = _gameModel.firstNum - _gameModel.secondNum;
    } else if (_gameModel.sign == 'X') {
      trueAnswer = _gameModel.firstNum * _gameModel.secondNum;
    } else if (_gameModel.sign == '/') {
      trueAnswer = _gameModel.firstNum ~/ _gameModel.secondNum;
    }
    _gameModel.trueAnswer = trueAnswer;
    notifyListeners();
  }

  setSign(String sign) {
    _gameModel.sign = sign;
    notifyListeners();
  }

  // update score every time user have right answer (add 1 point)
  updateScore() {
    _gameModel.score++;
    updateLevel();
    notifyListeners();
  }

  setLevel(int lvl) {
    _gameModel.level = lvl;
    notifyListeners();
  }

  updateLevel() {
    // from 1 --> 4 = lvl 1, from 5 --> 9 = lvl 2 etc.
    setLevel((_gameModel.score / 5).floor() + 1);
    if (_gameModel.score == 70) {
      youAreWinner();
    }
    notifyListeners();
  }

  setQuestion();

  setQestionDetails(int remSeconds, String sign, int firstNumMin,
      int firstNumMax, int secondNumMin, secondNumMax);

  // method to check repetation and submit the question
  void checkRepetationAndSubmit(
      int firstNumMin, int firstNumMax, int secondNumMin, int secondNumMax) {
    // set first and second nums
    setFirstAndSecondNums(firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    if (_gameModel.sign == '-') {
      if (_gameModel.firstNum < _gameModel.secondNum) {
        int temp = _gameModel.firstNum;
        _gameModel.firstNum = _gameModel.secondNum;
        _gameModel.secondNum = temp;
      }
    }
    if (_gameModel.firstNum == lastFirst ||
        _gameModel.firstNum == lastSecond &&
            _gameModel.secondNum == lastFirst ||
        _gameModel.secondNum == lastSecond) {
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

  void setFirstAndSecondNums(
      int firstNumMin, int firstNumMax, int secondNumMin, int secondNumMax) {
    setFirstNum(generateRandomNum(firstNumMin, firstNumMax));
    setSecondNum(generateRandomNum(secondNumMin, secondNumMax));
  }

  youAreWinner() {}
}
