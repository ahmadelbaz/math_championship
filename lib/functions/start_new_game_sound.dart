import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();

playStartNewGameSound() async {
  audioCache.play('sounds/startNewGame.mp3', mode: PlayerMode.LOW_LATENCY);
}
