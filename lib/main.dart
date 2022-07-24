import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:math_championship/providers/achievement_provider.dart';
import 'package:math_championship/providers/settings_provider.dart';
import 'package:math_championship/providers/store_provider.dart';
import 'package:math_championship/screens/about_us_screen.dart';
import 'package:math_championship/screens/game_screen.dart';
import 'package:math_championship/screens/introduction_screen.dart';
import 'package:math_championship/screens/profile_screen.dart';
import 'package:math_championship/screens/settings_screen.dart';
import 'package:math_championship/screens/store_screen.dart';
import 'package:math_championship/screens/welcome_screen.dart';
import 'package:math_championship/screens/result_screen.dart';
import 'package:math_championship/screens/start_screen.dart';

import 'constants.dart';
import 'providers/modes_provider.dart';
import 'providers/points_provider.dart';

// Global key so that we can get a context in any place we want
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Change notifier provider for SettingsProvider
final settingsChangeNotifierProvider =
    ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

// Change notifier provider for StoreProvider
final storeChangeNotifierProvider =
    ChangeNotifierProvider<StoreProvider>((ref) => StoreProvider());

// Change notifier provider for ModesProvider
final modesChangeNotifierProvider =
    ChangeNotifierProvider<ModesProvider>((ref) => ModesProvider());

// Change notifier provider for PointsProvider
final pointsChangeNotifierProvider =
    ChangeNotifierProvider<PointsProvider>((ref) => PointsProvider());

// Change notifier provider for AchievementsProvider
final achievementsChangeNotifierProvider =
    ChangeNotifierProvider<AchievementProvider>((ref) => AchievementProvider());

// State provider to detect which mode we are using now
final modeStateProvider = StateProvider<int>((ref) => 0);

// State provider to control the timer in game
final timerStateProvider = StateProvider<Timer>(
    (ref) => Timer.periodic(const Duration(seconds: 0), (_) {}));

// Future provider to get data from shared prefs and detect if this is the first time for the user or not
final isFirstFutureProvider = FutureProvider(
  (ref) async {
    final selected = ref
        .read(settingsChangeNotifierProvider)
        .setIsFirstTime(await IsFirstRun.isFirstRun());
    return selected;
  },
);

Future<void> main() async {
  runApp(const ProviderScope(child: MyApp()));
  // Hide status bar & navigation bar, and show them when user swipe at the edges of the display.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    // Initialize providers
    final settingsProvider = watch(settingsChangeNotifierProvider);
    final futureProvider = watch(isFirstFutureProvider);
    // We use future provider here to let the data load before screen
    return futureProvider.when(
      data: (data) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          // Assign screen height and width to these global variables so we can use them in all screens
          deviceWidth = MediaQuery.of(context).size.width;
          deviceHeight = MediaQuery.of(context).size.width;
          return Theme(
            data: ThemeData(
              // Main font of the app, we stored it in const file
              fontFamily: settingsProvider.mainFont,
              primaryColor: settingsProvider.currentTheme[1],
              textTheme: TextTheme(
                headline1: TextStyle(
                  fontSize: deviceWidth * 0.2,
                ),
                bodyText1: TextStyle(
                  fontSize: deviceWidth * 0.083,
                  color: settingsProvider.currentTheme[3],
                ),
                bodyText2: TextStyle(
                  fontSize: deviceWidth * 0.067,
                ),
                subtitle2: TextStyle(
                    fontSize: deviceWidth * 0.097,
                    color: settingsProvider.currentTheme[2]),
                headline2: TextStyle(
                    fontSize: deviceWidth * 0.05,
                    color: settingsProvider.currentTheme[1]),
                headline3: TextStyle(
                    fontSize: deviceWidth * 0.05,
                    color: settingsProvider.currentTheme[0],
                    fontFamily: settingsProvider.secondaryFont),
                headline4: TextStyle(
                  fontSize: deviceWidth * 0.089,
                  color: settingsProvider.currentTheme[1],
                  fontFamily: settingsProvider.secondaryFont,
                ),
                // this is for appBar
                headline5: TextStyle(
                  fontSize: deviceWidth * 0.058,
                  color: settingsProvider.currentTheme[1],
                ),
                headline6: TextStyle(
                  fontSize: deviceWidth * 0.1,
                  color: settingsProvider.currentTheme[0],
                ),
              ),
            ),
            child: child!,
          );
        },
        routes: {
          // We check if this is the first time for user using the app or not
          // and based on that we change the first screen he sees.
          '/': (ctx) => settingsProvider.isFirstTimeApp
              ? const OnBoardingPage()
              : WelcomeScreen(),
          '/profile_screen': (ctx) => ProfileScreen(),
          '/start_screen': (ctx) => StartScreen(),
          '/game_screen': (ctx) => const GameScreen(),
          '/result_screen': (ctx) => const ResultScreen(),
          '/settings_screen': (ctx) => const SettingsScreen(),
          '/store_screen': (ctx) => const StoreScreen(),
          '/aboutus_screen': (ctx) => const AboutUsScreen(),
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
