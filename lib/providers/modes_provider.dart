import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:math_championship/database/database.dart';
import 'package:math_championship/models/mode_model.dart';

class ModesProvider extends ChangeNotifier {
  List<Mode> _modes = [];

  MyDatabase myDatabase = MyDatabase();

  UnmodifiableListView get modes => UnmodifiableListView(_modes);

  Future<void> updateHighScore(Mode mode, String id) async {
    Mode newMode = _modes.firstWhere((element) => element.id == id);
    log(mode.name);
    log('${mode.highScore}');
    int index = _modes.indexOf(newMode);
    _modes[index] = mode;
    await myDatabase.mathDatabase();
    await myDatabase.update(mode);
    notifyListeners();
  }

  Future<void> getAllModes() async {
    await myDatabase.mathDatabase();
    _modes = await myDatabase.getAll('modes', 'math_database') as List<Mode>;
    notifyListeners();
  }
}
