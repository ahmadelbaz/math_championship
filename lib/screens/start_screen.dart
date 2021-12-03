import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/start_mode_function.dart';
import 'package:math_championship/models/solve_game_model.dart';
import 'package:math_championship/providers/modes_provider.dart';
import 'package:math_championship/providers/points_provider.dart';
import 'package:math_championship/screens/solve_mode_screen.dart';
import 'package:math_championship/screens/timeiseverthing_mode_screen.dart';
import 'package:math_championship/widgets/mode_widget.dart';
import 'package:math_championship/widgets/score_board.dart';

import '../constants.dart';

final modesChangeNotifierProvider =
    ChangeNotifierProvider<ModesProvider>((ref) => ModesProvider());

final pointsChangeNotifierProvider =
    ChangeNotifierProvider<PointsProvider>((ref) => PointsProvider());

// state provider to check if we are in game or not
final inGameStateProvider = StateProvider<bool>((ref) => false);

// futureProvider to get modes from database
final modesFutureProvider = FutureProvider(
  (ref) async {
    final selected = ref.read(modesChangeNotifierProvider).getAllModes();
    final selected2 = ref.read(pointsChangeNotifierProvider).getAllPoints();
    return selected;
  },
);

class StartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    final _modesProvider = watch(modesChangeNotifierProvider);
    final _pointsProvider = watch(pointsChangeNotifierProvider);
    final _futureProvider = watch(modesFutureProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        title: ScoreBoard(_pointsProvider.getPoints().mathPoints,
            _pointsProvider.getPoints().mathCoins),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: kMainColor,
      body: _futureProvider.when(
        data: (data) {
          return ListView.builder(
              itemCount: _modesProvider.modes.length,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: _size.height * 0.05,
                    ),
                    ModeWidget(() {
                      startMode(watch, context, index);
                    },
                        _modesProvider.modes[index].name,
                        _modesProvider.modes[index].highScore,
                        _modesProvider.modes[index].highScoreDateTime),
                  ],
                );
              });
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
