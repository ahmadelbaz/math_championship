import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../providers/game_provider.dart';
import '../screens/game_screen.dart';

// Method to decide which provider we wanna use based on which mode the player chose
// And it is in ascending order as '0' will be solve provider and '1' will be random sign provider etc
// So if we added more modes in the future ()according to our plans) or changed current modes order
// We have to change things here
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
