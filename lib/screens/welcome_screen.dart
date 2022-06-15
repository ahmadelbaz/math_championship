import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/providers/user_provider.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';
import 'package:lottie/lottie.dart';
import '../functions/play_sounds.dart';
import '../main.dart';

final userChangeNotifierProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

final userFutureProvider = FutureProvider((ref) async {
  final selected = await ref.read(userChangeNotifierProvider).getUserData();
  return selected;
});

class WelcomeScreen extends ConsumerWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  DateTime timeBackPressed = DateTime.now();

  Future<bool> _onBackPressed() async {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      customSnackBar('Press again to exit');
      return false;
    } else {
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true;
    }
  }

  Future<bool> _onBackAlertDialog(BuildContext context) async {
    bool _quitOrNot = false;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('You will close the game, Are you sure ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              _quitOrNot = false;
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              _quitOrNot = true;
              Navigator.of(context).pop();
              await SystemChannels.platform
                  .invokeMethod<void>('SystemNavigator.pop');
            },
            child: const Text('Quit'),
          ),
        ],
      ),
    );
    log('this is return $_quitOrNot');
    return _quitOrNot;
  }

  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    var _userProvider = watch(userChangeNotifierProvider);
    var _futureProvider = watch(userFutureProvider);
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    TextStyle defaultStyle =
        TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(
      fontFamily: 'rimouski',
      fontSize: 32,
      color: Theme.of(context).primaryColor,
      decoration: TextDecoration.underline,
    );
    return _futureProvider.when(
      data: (data) => WillPopScope(
        onWillPop: () => _onBackAlertDialog(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _settingsProvider.currentTheme[0],
            elevation: 0.0,
            title: FittedBox(
              child: Text(
                _userProvider.getUser().name == 'guest'
                    ? 'Welcome to MathChampionship'
                    : 'Welcome ${_userProvider.getUser().name}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          backgroundColor: _settingsProvider.currentTheme[0],
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
                              text: _userProvider.getUser().name == 'guest'
                                  ? 'You are playing as a guest, wanna '
                                  : ''),
                          TextSpan(
                            style: linkStyle,
                            text: _userProvider.getUser().name == 'guest'
                                ? 'Create Profile ?'
                                : '',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (_userProvider.getUser().name == 'guest') {
                                  Navigator.of(context)
                                      .pushNamed('/profile_screen');
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(_size.height * 0.07),
                          primary: Theme.of(context).primaryColor,
                          onPrimary: _settingsProvider.currentTheme[0],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          playGeneralSound(_settingsProvider.sounds[1]);
                          Navigator.of(context).pushNamed('/start_screen');
                        },
                        child: FittedBox(
                          child: Text(
                            _userProvider.getUser().name == 'guest'
                                ? 'Play as guest'
                                : 'Play',
                            style: const TextStyle(fontSize: 55),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(_size.width * 0.5, _size.height * 0.07),
                              primary: Theme.of(context).primaryColor,
                              onPrimary: _settingsProvider.currentTheme[0],
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              playGeneralSound(_settingsProvider.sounds[1]);
                              Navigator.of(context)
                                  .pushNamed('/profile_screen');
                            },
                            child: const Text(
                              'Profile',
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(_size.width * 0.2, _size.height * 0.07),
                              primary: Theme.of(context).primaryColor,
                              onPrimary: _settingsProvider.currentTheme[0],
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              playGeneralSound(_settingsProvider.sounds[1]);
                              Navigator.of(context)
                                  .pushNamed('/settings_screen');
                            },
                            child: const Icon(Icons.settings),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.3),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(_size.width * 0.2, _size.height * 0.07),
                          primary: Theme.of(context).primaryColor,
                          onPrimary: _settingsProvider.currentTheme[0],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          playGeneralSound(_settingsProvider.sounds[1]);
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
