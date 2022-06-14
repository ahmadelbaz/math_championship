import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/providers/modes_provider.dart';
import 'package:math_championship/providers/points_provider.dart';
import 'package:math_championship/widgets/mode_widget.dart';
import 'package:math_championship/widgets/score_board.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../functions/play_sounds.dart';
import '../functions/start_mode_function.dart';
import '../main.dart';

final modesChangeNotifierProvider =
    ChangeNotifierProvider<ModesProvider>((ref) => ModesProvider());

final pointsChangeNotifierProvider =
    ChangeNotifierProvider<PointsProvider>((ref) => PointsProvider());

// state provider to check if we are in game or not
final inGameStateProvider = StateProvider<bool>((ref) => false);

// provider to check on current stage (timer or start)
final stageStateProvider = StateProvider<bool>((ref) => false);
final timerProvider = StateProvider<int>((ref) => 3);

// futureProvider to get modes from database
final modesFutureProvider = FutureProvider(
  (ref) async {
    final selected = ref.read(modesChangeNotifierProvider).getAllModes();
    final selected2 = ref.read(pointsChangeNotifierProvider).getAllPoints();
    return selected;
  },
);

class StartScreen extends ConsumerWidget {
  bool isFirst = false;
  StartScreen({Key? key, this.isFirst = false}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    // Disable Screen Rotation Orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // get screen size
    final _size = MediaQuery.of(context).size;
    final _modesProvider = watch(modesChangeNotifierProvider);
    final _pointsProvider = watch(pointsChangeNotifierProvider);
    final _timerProvider = watch(timerProvider);
    final _stageProvider = watch(stageStateProvider);
    final _futureProvider = watch(modesFutureProvider);
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: ScoreBoard(_pointsProvider.getPoints().mathPoints,
            _pointsProvider.getPoints().mathCoins),
        actions: [
          IconButton(
            onPressed: () {
              playGeneralSound(_settingsProvider.sounds[1]);
              Navigator.of(context).pushNamed('/settings_screen');
            },
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      backgroundColor: kMainColor,
      body: _futureProvider.when(
        data: (data) {
          return Padding(
            padding: EdgeInsets.only(top: _size.height * 0.05),
            child: ListView.builder(
              itemCount: _modesProvider.modes.length,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    ModeWidget(
                      index,
                      () async {
                        if (_modesProvider.modes[index].locked == 1) {
                          if (_modesProvider.checkPrice(
                              _modesProvider.modes[index].id,
                              _pointsProvider.getPoints().mathCoins)) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Unlock Mode'),
                                content: Text(
                                    'Do you want to unlock \'${_modesProvider.modes[index].name.toString()}\' mode ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      _modesProvider.unlockMode(
                                          _modesProvider.modes[index].id,
                                          _pointsProvider.getPoints().mathCoins,
                                          _pointsProvider);
                                    },
                                    child: const Text('Unlock'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: const Text('Not enough money!'),
                                      content: const Text(
                                          'You don\'t have enough coins, keep going and try again later.'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Sure'))
                                      ],
                                    ));
                          }
                        } else {
                          startMode(watch, context, index);
                        }

                        // _modesProvider.modes[index].locked == 1
                        //     ? _modesProvider.checkPrice(
                        //         _modesProvider.modes[index].id,
                        //         _pointsProvider.getPoints().mathCoins) ? _modesProvider.unlockMode(_modesProvider.modes[index].id,
                        //         _pointsProvider.getPoints().mathCoins, _pointsProvider)
                        //     : startMode(watch, context, index);
                      },
                    ),
                    SizedBox(
                      height: _size.height * 0.05,
                    ),
                  ],
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
