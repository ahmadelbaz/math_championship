import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/general_click_sound.dart';
import 'package:math_championship/providers/modes_provider.dart';
import 'package:math_championship/providers/points_provider.dart';
import 'package:math_championship/widgets/mode_widget.dart';
import 'package:math_championship/widgets/score_board.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../functions/stage_timer.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: ScoreBoard(_pointsProvider.getPoints().mathPoints,
            _pointsProvider.getPoints().mathCoins),
        actions: [
          IconButton(
            onPressed: () {
              playGeneralClickSound();
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
      body: _stageProvider.state
          ? Center(
              child: Text('${_timerProvider.state}'),
            )
          : _futureProvider.when(
              data: (data) {
                return ListView.builder(
                  itemCount: _modesProvider.modes.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: _size.height * 0.05,
                        ),
                        ModeWidget(() async {
                          stageTimer(watch, context, index);
                          // startMode(watch, context, index);
                          // await Future.delayed(
                          //     const Duration(milliseconds: 3000), () {
                          //   startMode(watch, context, index);
                          // });
                        },
                            _modesProvider.modes[index].name,
                            _modesProvider.modes[index].highScore,
                            _modesProvider.modes[index].highScoreDateTime),
                      ],
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
    );
  }
}
