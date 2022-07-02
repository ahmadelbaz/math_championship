import 'package:math_championship/providers/game_provider.dart';

class SolveProvider extends GameProvider {
  @override
  void setQuestion() {
    // lvl 1 question (score > 5, sign '+')
    if (gameModel.level == 1) {
      setQestionDetails(1250, '+', 1, 4, 1, 4);
    }
    // lvl 2 question (5 < score > 10, sign '+')
    else if (gameModel.level == 2) {
      setQestionDetails(1250, '+', 5, 4, 1, 4);
    }
    // lvl 3 question (10 < score > 15, sign 'X')
    else if (gameModel.level == 3) {
      setQestionDetails(1250, 'X', 1, 4, 1, 4);
    }
    // lvl 4 question (15 < score > 20, sign '-')
    else if (gameModel.level == 4) {
      setQestionDetails(1250, '-', 5, 4, 1, 4);
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

  // method gets details of the question and set the values in their functions
  @override
  void setQestionDetails(int remSeconds, String sign, int firstNumMin,
      int firstNumMax, int secondNumMin, secondNumMax) {
    setRemainingSeconds(remSeconds);
    setSign(sign);
    checkRepetationAndSubmit(
        firstNumMin, firstNumMax, secondNumMin, secondNumMax);
    notifyListeners();
  }
}
