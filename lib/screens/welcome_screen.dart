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
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
        ),
        backgroundColor: kMainColor,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: _size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/start_screen');
                      },
                      child: Text(_userProvider.getUser().name == 'guest'
                          ? 'Play as guest'
                          : 'Play'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
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
