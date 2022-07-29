// Model for game, its more wide than one mode, its for all modes
class GameModel {
  int firstNum;
  int secondNum;
  int remainSeconds;
  int trueAnswer;
  String sign;
  int level;
  int score;

  GameModel(this.firstNum, this.secondNum, this.trueAnswer, this.remainSeconds,
      this.sign, this.level, this.score);
}
