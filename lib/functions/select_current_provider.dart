import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../providers/game_provider.dart';
import '../screens/game_screen.dart';

GameProvider selectCurrentProvider(
    T Function<T>(ProviderBase<Object?, T>) watch) {
  final _modeProvider = watch(modeStateProvider);
  return _modeProvider.state == 0
      ? watch(solveChangeNotifierProvider)
      : _modeProvider.state == 1
          ? watch(randomSignChangeNotifierProvider)
          : _modeProvider.state == 2
              ? watch(timeIsEveryThingChangeNotifierProvider)
              : _modeProvider.state == 3
                  ? watch(doubleValueChangeNotifierProvider)
                  : watch(squareRootChangeNotifierProvider);
}
