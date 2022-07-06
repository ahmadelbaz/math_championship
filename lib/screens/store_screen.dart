import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/screens/start_screen.dart';
import 'package:math_championship/widgets/custom_color_stack.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';

import '../functions/play_sounds.dart';
import '../main.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    final _storeProvider = watch(storeChangeNotifierProvider);
    final _modesProvider = watch(modesChangeNotifierProvider);
    return Scaffold(
      backgroundColor: _settingsProvider.currentTheme[0],
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).primaryColor),
        title: Text(
          'Store',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        backgroundColor: _settingsProvider.currentTheme[0],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: _size.height * 0.02,
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
                  itemCount: _storeProvider.themesForSale.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playScoreBoardSound(_settingsProvider.sounds[3]);
                            _storeProvider.onThemeClick(context, index);
                          },
                          onLongPress: () {
                            customSnackBar('$themePrice Math Coins');
                          },
                          child: CustomColorStack(
                              _storeProvider.themesForSale[index]),
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
