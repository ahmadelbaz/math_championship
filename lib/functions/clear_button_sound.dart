import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();

playclearButtonSound() async {
  audioCache.play('sounds/clearButtonSound.mp3', mode: PlayerMode.LOW_LATENCY);
}
