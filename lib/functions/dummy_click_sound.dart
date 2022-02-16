import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();

playInGameClickSound() async {
  audioCache.play('sounds/bottonClick.mp3', mode: PlayerMode.LOW_LATENCY);
}
