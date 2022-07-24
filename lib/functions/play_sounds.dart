import 'package:audioplayers/audioplayers.dart';

// All sound methods, each method taks bool parameter
// To check if user turned this sound off from the settings or not

AudioCache audioCache = AudioCache();

// General sound (button clicks)
playGeneralSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/generalButtonsClick.wav',
        mode: PlayerMode.LOW_LATENCY);
  }
}

// Sound when user want to start a game
playStartGameSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/startNewGame.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}

// Sound when user click on math coins or math points, correct answer sound and achievement sound
playScoreBoardSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/buttonClick.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}

// Sound when user lose the game
playGameOverSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/gameOver.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}

// When user delete something or clear a number in the game
playInGameClearSound(bool isWorking) async {
  if (isWorking) {
    audioCache.play('sounds/clearButtonSound.mp3',
        mode: PlayerMode.LOW_LATENCY);
  }
}
