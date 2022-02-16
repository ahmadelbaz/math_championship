import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();

playGameOverSound() async {
  audioCache.play('sounds/gameOver.mp3', mode: PlayerMode.LOW_LATENCY);
}
