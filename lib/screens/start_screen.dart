import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/widgets/mode_widget.dart';
import 'package:math_championship/widgets/score_board.dart';
import 'package:flutter/services.dart';

import '../functions/play_sounds.dart';
import '../main.dart';

// state provider to check if we are in game or not
final inGameStateProvider = StateProvider<bool>((ref) => false);

// provider to check on current stage (timer or start)
final stageStateProvider = StateProvider<bool>((ref) => false);
final timerProvider = StateProvider<int>((ref) => 3);

// // futureProvider to get modes from database
// final modesFutureProvider = FutureProvider(
//   (ref) async {
//     final selected = ref.read(modesChangeNotifierProvider).getAllModes();
//     final selected2 = ref.read(pointsChangeNotifierProvider).getAllPoints();
//     return selected;
//   },
// );

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
    // final _futureProvider = watch(userFutureProvider);
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _settingsProvider.currentTheme[0],
        elevation: 0,
        automaticallyImplyLeading: false,
        title: ScoreBoard(_pointsProvider.getPoints().mathPoints,
            _pointsProvider.getPoints().mathCoins),
        actions: [
          IconButton(
            onPressed: () {
              playGeneralSound(_settingsProvider.sounds[1]);
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
          ),
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
      backgroundColor: _settingsProvider.currentTheme[0],
      body: Padding(
        padding: EdgeInsets.only(top: _size.height * 0.05),
        child: ListView.builder(
          itemCount: _modesProvider.modes.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ModeWidget(
                    index, () => _modesProvider.onClickMode(context, index)),
                SizedBox(
                  height: _size.height * 0.05,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
