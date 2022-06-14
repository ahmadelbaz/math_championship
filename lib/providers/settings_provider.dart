import 'package:flutter/widgets.dart';

class SettingsProvider extends ChangeNotifier {
  final List<bool> _sounds = [true, true, true, true, true, true, true];

  List<bool> get sounds => _sounds;

  switchSounds(bool value) {
    for (int n = 0; n < _sounds.length; n++) {
      _sounds[n] = value;
    }
    notifyListeners();
  }

  switchGeneralSound(value) {
    _sounds[1] = value;
    notifyListeners();
  }

  switchStartGameSound(value) {
    _sounds[2] = value;
    notifyListeners();
  }

  switchScoreBoardSound(value) {
    _sounds[3] = value;
    notifyListeners();
  }

  switchCorrectAnswerSound(value) {
    _sounds[4] = value;
    notifyListeners();
  }

  switchWrongAnswerSound(value) {
    _sounds[5] = value;
    notifyListeners();
  }

  switchInGameClearSound(value) {
    _sounds[6] = value;
    notifyListeners();
  }

  // enableAllSounds() {
  //   _generalSoundOn = true;
  //   _startGameSoundOn = true;
  //   _scoreBoardSoundOn = true;
  //   _inGameClickSoundOn = true;
  //   _inGameClearSoundOn = true;
  //   notifyListeners();
  // }
}
