import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/providers/user_provider.dart';
import 'package:math_championship/widgets/custom_alert_dialog.dart';
import 'package:lottie/lottie.dart';
import '../functions/play_sounds.dart';
import '../main.dart';

final userChangeNotifierProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

final userFutureProvider = FutureProvider((ref) async {
  final selected = await ref.read(userChangeNotifierProvider).getUserData();
  ref.read(modesChangeNotifierProvider).getAllModes();
  ref.read(pointsChangeNotifierProvider).getAllPoints();
  return selected;
});

class WelcomeScreen extends ConsumerWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  DateTime timeBackPressed = DateTime.now();

  static Future<void> pop({bool? animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }

  // Future<bool> _onBackPressed() async {
  //   final difference = DateTime.now().difference(timeBackPressed);
  //   final isExitWarning = difference >= const Duration(seconds: 2);

  //   timeBackPressed = DateTime.now();

  //   if (isExitWarning) {
  //     customSnackBar('Press again to exit');
  //     return false;
  //   } else {
  //     await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  //     return true;
  //   }
  // }

  Future<bool> _onBackAlertDialog(BuildContext context) async {
    bool quitOrNot = false;
    customAlertDialog(
      const Text('Are you sure?'),
      Text('You will close the game, Are you sure ?',
          style: Theme.of(context).textTheme.headline3),
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();

            quitOrNot = false;
          },
          child: Text('Cancel',
              style: TextStyle(
                  color: context
                      .read(settingsChangeNotifierProvider)
                      .currentTheme[0])),
        ),
        TextButton(
          onPressed: () async {
            quitOrNot = true;
            Navigator.of(context).pop();
            // SystemNavigator.pop();

            await pop();
          },
          child: Text('Quit',
              style: TextStyle(
                  color: context
                      .read(settingsChangeNotifierProvider)
                      .currentTheme[0])),
        ),
      ],
    );
    // showDialog(
    //   context: context,
    //   builder: (ctx) => AlertDialog(
    //     title: const Text('Are you sure?'),
    //     content: const Text('You will close the game, Are you sure ?'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();

    //           _quitOrNot = false;
    //         },
    //         child: const Text('Cancel'),
    //       ),
    //       TextButton(
    //         onPressed: () async {
    //           _quitOrNot = true;
    //           Navigator.of(context).pop();
    //           await SystemChannels.platform
    //               .invokeMethod<void>('SystemNavigator.pop');
    //         },
    //         child: const Text('Quit'),
    //       ),
    //     ],
    //   ),
    // );
    log('this is return $quitOrNot');
    return quitOrNot;
  }

  @override
  Widget build(BuildContext context, watch) {
    final size = MediaQuery.of(context).size;
    var userProvider = watch(userChangeNotifierProvider);
    var futureProvider = watch(userFutureProvider);
    final settingsProvider = watch(settingsChangeNotifierProvider);
    TextStyle defaultStyle =
        TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(
      fontFamily: 'rimouski',
      fontSize: 32,
      color: Theme.of(context).primaryColor,
      decoration: TextDecoration.underline,
    );
    return futureProvider.when(
      data: (data) => WillPopScope(
        onWillPop: () => _onBackAlertDialog(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: settingsProvider.currentTheme[0],
            elevation: 0.0,
            title: FittedBox(
              child: Text(
                userProvider.getUser().name == 'guest'
                    ? 'Welcome to MathChampionship'
                    : 'Welcome ${userProvider.getUser().name}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          backgroundColor: settingsProvider.currentTheme[0],
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Lottie.asset('assets/animations/math.json'),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          TextSpan(
                              style: const TextStyle(fontFamily: 'rimouski'),
                              text: userProvider.getUser().name == 'guest'
                                  ? 'You are playing as a guest, wanna '
                                  : ''),
                          TextSpan(
                            style: linkStyle,
                            text: userProvider.getUser().name == 'guest'
                                ? 'Create Profile ?'
                                : '',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (userProvider.getUser().name == 'guest') {
                                  Navigator.of(context)
                                      .pushNamed('/profile_screen');
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(size.height * 0.07),
                          primary: Theme.of(context).primaryColor,
                          onPrimary: settingsProvider.currentTheme[0],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          playGeneralSound(settingsProvider.sounds[1]);
                          Navigator.of(context).pushNamed('/start_screen');
                        },
                        child: FittedBox(
                          child: Text(
                            userProvider.getUser().name == 'guest'
                                ? 'Play as guest'
                                : 'Play',
                            style: const TextStyle(fontSize: 55),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(size.height * 0.07),
                          primary: Theme.of(context).primaryColor,
                          onPrimary: settingsProvider.currentTheme[0],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          playGeneralSound(settingsProvider.sounds[1]);
                          Navigator.of(context).pushNamed('/profile_screen');
                        },
                        child: const Text(
                          'Profile',
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(size.width * 0.2, size.height * 0.07),
                              primary: Theme.of(context).primaryColor,
                              onPrimary: settingsProvider.currentTheme[0],
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              playGeneralSound(settingsProvider.sounds[1]);
                              Navigator.of(context)
                                  .pushNamed('/settings_screen');
                            },
                            child: const Icon(Icons.settings),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(size.width * 0.2, size.height * 0.07),
                              primary: Theme.of(context).primaryColor,
                              onPrimary: settingsProvider.currentTheme[0],
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              playGeneralSound(settingsProvider.sounds[1]);
                              Navigator.of(context).pushNamed('/store_screen');
                            },
                            child:
                                const Icon(Icons.local_grocery_store_rounded),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(size.width * 0.2, size.height * 0.07),
                              primary: Theme.of(context).primaryColor,
                              onPrimary: settingsProvider.currentTheme[0],
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              playGeneralSound(settingsProvider.sounds[1]);
                              Navigator.of(context)
                                  .pushNamed('/aboutus_screen');
                            },
                            child: const Icon(
                                Icons.system_security_update_warning_sharp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.3),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(size.width * 0.2, size.height * 0.07),
                          primary: Theme.of(context).primaryColor,
                          onPrimary: settingsProvider.currentTheme[0],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          playGeneralSound(settingsProvider.sounds[1]);
                          _onBackAlertDialog(context);
                        },
                        child: const Text(
                          'Quit',
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
