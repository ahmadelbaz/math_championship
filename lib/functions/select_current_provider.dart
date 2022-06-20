import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../providers/game_provider.dart';
import '../screens/game_screen.dart';

GameProvider selectCurrentProvider(
    T Function<T>(ProviderBase<Object?, T>) watch) {
  return watch(modeStateProvider).state == 0
      ? watch(solveChangeNotifierProvider)
      : watch(modeStateProvider).state == 1
          ? watch(timeIsEveryThingChangeNotifierProvider)
          : watch(modeStateProvider).state == 2
              ? watch(randomSignChangeNotifierProvider)
              : watch(modeStateProvider).state == 3
                  ? watch(doubleValueChangeNotifierProvider)
                  : watch(squareRootChangeNotifierProvider);
}
