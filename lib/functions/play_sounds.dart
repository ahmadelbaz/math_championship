import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();

playGeneralSound(bool isWorking) async {
  if (isWorking) {
    // audioCache.play('sounds/generalButtonsClick.mp3',
    audioCache.play('sounds/generalButtonsClick.wav',
        mode: PlayerMode.LOW_LATENCY);
  }
}

playStartGameSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/startNewGame.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}

playScoreBoardSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/buttonClick.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}

playCorrectAnswerSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/buttonSound.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}

playGameOverSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/gameOver.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}

playInGameClearSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/clearButtonSound.mp3',
        mode: PlayerMode.LOW_LATENCY);
  }
}
