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

import 'providers/modes_provider.dart';
import 'providers/points_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final settingsChangeNotifierProvider =
    ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

final storeChangeNotifierProvider =
    ChangeNotifierProvider<StoreProvider>((ref) => StoreProvider());

final modesChangeNotifierProvider =
    ChangeNotifierProvider<ModesProvider>((ref) => ModesProvider());

final pointsChangeNotifierProvider =
    ChangeNotifierProvider<PointsProvider>((ref) => PointsProvider());

final achievementsChangeNotifierProvider =
    ChangeNotifierProvider<AchievementProvider>((ref) => AchievementProvider());

final modeStateProvider = StateProvider<int>((ref) => 0);

final timerStateProvider = StateProvider<Timer>(
    (ref) => Timer.periodic(const Duration(seconds: 0), (_) {}));

final isFirstFutureProvider = FutureProvider((ref) async {
  final selected = ref
      .read(settingsChangeNotifierProvider)
      .setIsFirstTime(await IsFirstRun.isFirstRun());
  return selected;
});

// futureProvider to get modes from database
// final modesFutureProvider = FutureProvider(
//   (ref) async {
//     final selected = ref.read(modesChangeNotifierProvider).getAllModes();
//     final selected2 = ref.read(pointsChangeNotifierProvider).getAllPoints();
//     return selected;
//   },
// );

Future<void> main() async {
  runApp(const ProviderScope(child: MyApp()));
  // AudioCache audioCache = AudioCache();

  // isFirstTime = await IsFirstRun.isFirstRun();
  // isFirstTime1 = await IsFirstRun.isFirstCall();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.pink, // status bar color
  // ));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context, watch) {
    // checkFirstTime();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: _settingsProvider.currentTheme[0], // status bar color
    // ));
    final settingsProvider = watch(settingsChangeNotifierProvider);
    final futureProvider = watch(isFirstFutureProvider);
    print('third : ${settingsProvider.isFirstTimeApp}');
    return futureProvider.when(
      data: (data) => MaterialApp(
        // onGenerateRoute: generateRoute,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: settingsProvider.mainFont,
          appBarTheme: const AppBarTheme(
              // foregroundColor: Colors.teal //here you can give the text color
              ),
          primaryColor: settingsProvider.currentTheme[1],
          textTheme: TextTheme(
            headline1: const TextStyle(
              fontSize: 72.0,
            ),
            bodyText1: TextStyle(
              fontSize: 30.0,
              color: settingsProvider.currentTheme[3],
            ),
            bodyText2: const TextStyle(
              fontSize: 24.0,
            ),
            subtitle2: TextStyle(
                fontSize: 35.0, color: settingsProvider.currentTheme[2]),
            headline2: TextStyle(
                fontSize: 18.0, color: settingsProvider.currentTheme[1]),
            headline3: TextStyle(
                fontSize: 18.0,
                color: settingsProvider.currentTheme[0],
                fontFamily: settingsProvider.secondaryFont),
            headline4: TextStyle(
              fontSize: 32.0,
              color: settingsProvider.currentTheme[1],
              fontFamily: settingsProvider.secondaryFont,
            ),
            // this is for appBar
            headline5: TextStyle(
              fontSize: 21.0,
              color: settingsProvider.currentTheme[1],
            ),
            headline6: TextStyle(
              fontSize: 36.0,
              color: settingsProvider.currentTheme[0],
            ),
          ),
        ),
        routes: {
          // '/': (ctx) => HomeScreen(),
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
