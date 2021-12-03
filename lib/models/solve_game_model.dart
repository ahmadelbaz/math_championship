class GameModel {
  final int firstNum;
  final int secondNum;
  final int remainSeconds;
  final int trueAnswer;
  final String sign;
  final int level;
  final int score;

  GameModel(this.firstNum, this.secondNum, this.trueAnswer, this.remainSeconds,
      this.sign, this.level, this.score);
}
