import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();

playGeneralClickSound() async {
  audioCache.play('sounds/generalButtonsClick.mp3',
      mode: PlayerMode.LOW_LATENCY);
}
