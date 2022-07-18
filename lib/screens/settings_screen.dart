import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/main.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:math_championship/widgets/custom_alert_dialog.dart';
import 'package:math_championship/widgets/custom_color_stack.dart';

import '../constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_radio_list_tile.dart';

final colorPickerStateProvider = StateProvider<List<Color>>((ref) => []);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final size = MediaQuery.of(context).size;
    final settingsProvider = watch(settingsChangeNotifierProvider);
    final colorProvider = watch(colorPickerStateProvider);
    final achievementProvider = watch(achievementsChangeNotifierProvider);
    colorProvider.state
        .addAll([Colors.white, Colors.white, Colors.white, Colors.white]);
    return Scaffold(
      backgroundColor: settingsProvider.currentTheme[0],
      appBar: customAppBar(context, settingsProvider, 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // SizedBox(
            //   height: size.height * 0.02,
            // ),
            Row(
              children: [
                Text(
                  'Sound effects',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                // there is more to add here
              ],
            ),
            // SizedBox(
            //   height: size.height * 0.01,
            // ),
            customRadioListTile(
              context,
              settingsProvider,
              'Enable Sounds',
              settingsProvider.sounds[0],
              (value) {
                settingsProvider.switchSounds(value);
                return null;
              },
            ),
            customRadioListTile(
              context,
              settingsProvider,
              'Enable General sound',
              settingsProvider.sounds[0] ? settingsProvider.sounds[1] : false,
              (value) {
                settingsProvider.switchGeneralSound(value);
                return null;
              },
            ),
            customRadioListTile(
              context,
              settingsProvider,
              'Enable Start game sound',
              settingsProvider.sounds[0] ? settingsProvider.sounds[2] : false,
              (value) {
                settingsProvider.switchStartGameSound(value);
                return null;
              },
            ),
            customRadioListTile(
              context,
              settingsProvider,
              'Enable Score board sound',
              settingsProvider.sounds[0] ? settingsProvider.sounds[3] : false,
              (value) {
                settingsProvider.switchScoreBoardSound(value);
                return null;
              },
            ),
            customRadioListTile(
              context,
              settingsProvider,
              'Enable Correct Answer sound',
              settingsProvider.sounds[0] ? settingsProvider.sounds[4] : false,
              (value) {
                settingsProvider.switchCorrectAnswerSound(value);
                return null;
              },
            ),
            customRadioListTile(
              context,
              settingsProvider,
              'Enable Wrong Answer sound',
              settingsProvider.sounds[0] ? settingsProvider.sounds[5] : false,
              (value) {
                settingsProvider.switchWrongAnswerSound(value);
                return null;
              },
            ),
            customRadioListTile(
              context,
              settingsProvider,
              'Enable InGame Clear sound',
              settingsProvider.sounds[0] ? settingsProvider.sounds[6] : false,
              (value) {
                settingsProvider.switchInGameClearSound(value);
                return null;
              },
            ),
            Divider(
              endIndent: deviceWidth * 0.15,
              indent: deviceWidth * 0.15,
              color: settingsProvider.currentTheme[1].withOpacity(.3),
              thickness: 1,
            ),
            // SizedBox(
            //   height: size.height * 0.01,
            // ),
            Text(
              'Themes',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              width: 70,
              height: 70,
              child: Center(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: settingsProvider.themes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playScoreBoardSound(settingsProvider.sounds[3]);
                            settingsProvider.changeCurrentTheme(index);
                            // achievement : Change theme
                            achievementProvider.checkAchievement(
                                1, watch(pointsChangeNotifierProvider));
                          },
                          onLongPress: () {
                            settingsProvider.deleteTheme(context, index);
                          },
                          child:
                              customColorStack(settingsProvider.themes[index]),
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
            // SizedBox(
            //   height: size.height * 0.02,
            // ),
            Center(
              child: TextButton(
                onPressed: () async {
                  if (settingsProvider.canAddThemes) {
                    settingsProvider.addNewTheme([
                      await showColorPicker(context, watch, 3),
                      await showColorPicker(context, watch, 2),
                      await showColorPicker(context, watch, 1),
                      await showColorPicker(context, watch, 0),
                    ], achievementProvider, watch(pointsChangeNotifierProvider),
                        true);
                  } else {
                    settingsProvider.unlockAddingTheme(
                        context,
                        watch(pointsChangeNotifierProvider)
                            .getPoints()
                            .mathCoins,
                        watch(pointsChangeNotifierProvider),
                        settingsProvider);
                  }
                },
                child: Text(
                  'Add custom theme',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            // SizedBox(
            //   height: size.height * 0.01,
            // ),
            Divider(
              endIndent: deviceWidth * 0.15,
              indent: deviceWidth * 0.15,
              color: settingsProvider.currentTheme[1].withOpacity(.3),
              thickness: 1,
            ),
            Text(
              'Fonts',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: settingsProvider.fonts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playScoreBoardSound(settingsProvider.sounds[3]);
                            customAlertDialog(
                              const Text('Select type'),
                              Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      playGeneralSound(
                                          settingsProvider.sounds[1]);
                                      settingsProvider.setMainFont(
                                        settingsProvider.fonts[index],
                                      );
                                      Navigator.of(context).pop();
                                      // achievement : Change font
                                      achievementProvider.checkAchievement(2,
                                          watch(pointsChangeNotifierProvider));
                                    },
                                    title: Text(
                                      'Main Font',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      playGeneralSound(
                                          settingsProvider.sounds[1]);
                                      settingsProvider.setSecondaryFont(
                                          settingsProvider.fonts[index]);
                                      Navigator.of(context).pop();
                                      // achievement : Change font
                                      achievementProvider.checkAchievement(2,
                                          watch(pointsChangeNotifierProvider));
                                    },
                                    title: Text(
                                      'Secondary Font',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ],
                              ),
                              [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: settingsProvider.currentTheme[0],
                                    ),
                                  ),
                                ),
                              ],
                              height: deviceHeight * 0.4,
                            );
                          },
                          onLongPress: () {
                            settingsProvider.deleteFont(context, index);
                          },
                          child: Text(
                            'Select',
                            style: TextStyle(
                              fontFamily: settingsProvider.fonts[index],
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                            ),
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

  Future<Color> showColorPicker(BuildContext context,
      T Function<T>(ProviderBase<Object?, T>) watch, int index) async {
    final colorProvider = watch(colorPickerStateProvider);
    // colorProvider.state
    //     .addAll([Colors.white, Colors.white, Colors.white, Colors.white]);
    Color fc = Colors.white;
    Color changeColor = Colors.white;
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: fc,
                  onColorChanged: (color) {
                    colorProvider.state[index] = color;
                    fc = color;
                  },
                ),
                // Use Material color picker:
                //
                // child: MaterialPicker(
                //   pickerColor: fc,
                //   onColorChanged: (color) {
                //     colorProvider.state[index] = color;
                //     fc = color;
                //   },
                // showLabel: true, // only on portrait mode
                // ),
                //
                // Use Block color picker:
                //
                // child: BlockPicker(
                //   pickerColor: currentColor,
                //   onColorChanged: changeColor,
                // ),
                //
                // child: MultipleChoiceBlockPicker(
                //   pickerColors: currentColors,
                //   onColorsChanged: changeColors,
                // ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    colorProvider.state[index] = fc;
                    print(colorProvider.state[index]);
                    Navigator.of(context).pop();
                    // return colorProvider.state[index];
                  },
                ),
              ],
            ));
    return colorProvider.state[index];
  }
}
