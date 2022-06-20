import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/providers/settings_provider.dart';
import 'package:math_championship/screens/game_screen.dart';
import 'package:math_championship/screens/profile_screen.dart';
import 'package:math_championship/screens/settings_screen.dart';
import 'package:math_championship/screens/welcome_screen.dart';
import 'package:math_championship/screens/result_screen.dart';
import 'package:math_championship/screens/start_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final settingsChangeNotifierProvider =
    ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

final modeStateProvider = StateProvider<int>((ref) => 0);

void main() async {
  runApp(const ProviderScope(child: MyApp()));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.pink, // status bar color
  // ));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    return MaterialApp(
      // onGenerateRoute: generateRoute,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'wheaton-capitals',
        appBarTheme: const AppBarTheme(
            // foregroundColor: Colors.teal //here you can give the text color
            ),
        primaryColor: _settingsProvider.currentTheme[1],
        textTheme: TextTheme(
          headline1: const TextStyle(
            fontSize: 72.0,
          ),
          headline6: TextStyle(
              fontSize: 36.0, color: _settingsProvider.currentTheme[0]),
          bodyText1: TextStyle(
            fontSize: 30.0,
            color: _settingsProvider.currentTheme[3],
          ),
          bodyText2: const TextStyle(
            fontSize: 24.0,
          ),
          subtitle2: TextStyle(
              fontSize: 35.0, color: _settingsProvider.currentTheme[2]),
          headline2: TextStyle(
              fontSize: 18.0, color: _settingsProvider.currentTheme[1]),
          headline3: TextStyle(
              fontSize: 14.0, color: _settingsProvider.currentTheme[0]),
          headline4: TextStyle(
              fontSize: 32.0,
              color: _settingsProvider.currentTheme[1],
              fontFamily: 'rimouski'),
          // this is for appBar
          headline5: TextStyle(
              fontSize: 21.0, color: _settingsProvider.currentTheme[1]),
        ),
      ),
      routes: {
        // '/': (ctx) => HomeScreen(),
        '/': (ctx) => WelcomeScreen(),
        '/profile_screen': (ctx) => ProfileScreen(),
        '/start_screen': (ctx) => StartScreen(),
        '/game_screen': (ctx) => const GameScreen(),
        '/result_screen': (ctx) => const ResultScreen(),
        '/settings_screen': (ctx) => const SettingsScreen(),
      },
    );
  }
}
