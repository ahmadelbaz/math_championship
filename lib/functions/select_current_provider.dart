import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../providers/game_provider.dart';
import '../screens/game_screen.dart';

GameProvider selectCurrentProvider(
    T Function<T>(ProviderBase<Object?, T>) watch) {
  final modeProvider = watch(modeStateProvider);
  return modeProvider.state == 0
      ? watch(solveChangeNotifierProvider)
      : modeProvider.state == 1
          ? watch(randomSignChangeNotifierProvider)
          : modeProvider.state == 2
              ? watch(timeIsEveryThingChangeNotifierProvider)
              : modeProvider.state == 3
                  ? watch(doubleValueChangeNotifierProvider)
                  : watch(squareRootChangeNotifierProvider);
}
