import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();

playCorrectAnswerSound() async {
  audioCache.play('sounds/buttonSound.mp3', mode: PlayerMode.LOW_LATENCY);
}
