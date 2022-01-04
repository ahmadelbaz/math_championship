import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/providers/user_provider.dart';

final userChangeNotifierProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

final userFutureProvider = FutureProvider((ref) async {
  final selected = await ref.read(userChangeNotifierProvider).getUserData();
  return selected;
});

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    var _userProvider = watch(userChangeNotifierProvider);
    var _futureProvider = watch(userFutureProvider);
    TextStyle defaultStyle =
        TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      decoration: TextDecoration.underline,
    );
    return _futureProvider.when(
      data: (data) => Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          elevation: 0.0,
          title: FittedBox(
              child: Text(
            _userProvider.getUser().name == 'guest'
                ? 'Welcome to MathChampionship'
                : 'Welcome ${_userProvider.getUser().name}',
          )),
        ),
        backgroundColor: kMainColor,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: _size.height * 0.2,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: defaultStyle,
                      children: <TextSpan>[
                        TextSpan(
                            text: _userProvider.getUser().name == 'guest'
                                ? 'You are playing as a guest, wanna create a profile? '
                                : ''),
                        TextSpan(
                          style: linkStyle,
                          text: _userProvider.getUser().name == 'guest'
                              ? 'Create Profile'
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
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: kMainColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/start_screen');
                      },
                      child: Text(_userProvider.getUser().name == 'guest'
                          ? 'Play as guest'
                          : 'Play'),
                    ),
                  ),
                  SizedBox(
                    height: _size.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(_size.height * 0.07),
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: kMainColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/profile_screen');
                      },
                      child: const Text('Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
