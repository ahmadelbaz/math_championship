import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/screens/game_screen.dart';
import 'package:math_championship/screens/profile_screen.dart';
import 'package:math_championship/screens/settings_screen.dart';
import 'package:math_championship/screens/welcome_screen.dart';
import 'package:math_championship/screens/result_screen.dart';
import 'package:math_championship/screens/start_screen.dart';

import 'constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // onGenerateRoute: generateRoute,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'wheaton-capitals',
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.teal //here you can give the text color
            ),
        primaryColor: const Color(0xFF033B3D),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
          ),
          headline6: TextStyle(fontSize: 36.0, color: kMainColor),
          bodyText1: TextStyle(
            fontSize: 30.0,
            color: Colors.yellow,
          ),
          bodyText2: TextStyle(
            fontSize: 24.0,
          ),
          subtitle2: TextStyle(fontSize: 35.0, color: Color(0xFF474306)),
          headline2: TextStyle(fontSize: 18.0, color: Color(0xFF085750)),
          headline3: TextStyle(fontSize: 14.0, color: kMainColor),
          headline4: TextStyle(
              fontSize: 32.0, color: Color(0xFF033B3D), fontFamily: 'rimouski'),
          // this is for appBar
          headline5: TextStyle(fontSize: 21.0, color: Color(0xFF033B3D)),
        ),
      ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.teal),
      ),
      routes: {
        // '/': (ctx) => HomeScreen(),
        '/': (ctx) => const WelcomeScreen(),
        '/profile_screen': (ctx) => ProfileScreen(),
        '/start_screen': (ctx) => StartScreen(),
        '/solve_screen': (ctx) => GameScreen(),
        '/result_screen': (ctx) => const ResultScreen(),
        '/settings_screen': (ctx) => const SettingsScreen(),
      },
    );
  }
}
