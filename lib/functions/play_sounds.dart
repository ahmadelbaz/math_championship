import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();

playclearButtonSound() async {
  audioCache.play('sounds/clearButtonSound.mp3', mode: PlayerMode.LOW_LATENCY);
}

playCorrectAnswerSound() async {
  audioCache.play('sounds/buttonSound.mp3', mode: PlayerMode.LOW_LATENCY);
}

playSnackBarClickSound() async {
  audioCache.play('sounds/buttonClick.mp3', mode: PlayerMode.LOW_LATENCY);
}

playGameOverSound() async {
  audioCache.play('sounds/gameOver.mp3', mode: PlayerMode.LOW_LATENCY);
}

playGeneralClickSound() async {
  audioCache.play('sounds/generalButtonsClick.mp3',
      mode: PlayerMode.LOW_LATENCY);
}

playStartNewGameSound() async {
  audioCache.play('sounds/startNewGame.mp3', mode: PlayerMode.LOW_LATENCY);
}
