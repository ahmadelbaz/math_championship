import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/widgets/custom_app_bar.dart';
import 'package:math_championship/widgets/custom_color_stack.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';

import '../functions/play_sounds.dart';
import '../main.dart';
import '../widgets/score_board.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final size = MediaQuery.of(context).size;
    final settingsProvider = watch(settingsChangeNotifierProvider);
    final storeProvider = watch(storeChangeNotifierProvider);
    final pointsProvider = watch(pointsChangeNotifierProvider);
    return Scaffold(
      backgroundColor: settingsProvider.currentTheme[0],
      appBar: customAppBar(context, settingsProvider, 'Store'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ScoreBoard(pointsProvider.getPoints().mathPoints,
                pointsProvider.getPoints().mathCoins),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Themes',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              width: 70,
              height: 100,
              child: Center(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: storeProvider.themesForSale.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playScoreBoardSound(settingsProvider.sounds[3]);
                            storeProvider.onThemeClick(context, index);
                          },
                          onLongPress: () {
                            customSnackBar('$themePrice Math Coins');
                          },
                          child: customColorStack(
                              storeProvider.themesForSale[index]),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Fonts',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              width: 70,
              height: 100,
              child: Center(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: storeProvider.fontsForSale.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playScoreBoardSound(settingsProvider.sounds[3]);
                            storeProvider.onFontClick(context, index);
                          },
                          onLongPress: () {
                            customSnackBar('$fontPrice Math Coins');
                          },
                          child: Text(
                            'Play',
                            style: TextStyle(
                                fontFamily: storeProvider.fontsForSale[index],
                                fontSize: 35),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
