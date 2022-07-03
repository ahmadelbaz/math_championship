import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/main.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../widgets/custom_radio_list_tile.dart';

final colorPickerStateProvider = StateProvider<List<Color>>((ref) => []);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    final colorProvider = watch(colorPickerStateProvider);
    colorProvider.state
        .addAll([Colors.white, Colors.white, Colors.white, Colors.white]);
    return Scaffold(
      backgroundColor: _settingsProvider.currentTheme[0],
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).primaryColor),
        title: Text(
          'Settings',
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
            Row(
              children: [
                Text(
                  'Sound effects',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                // there is more to add here
              ],
            ),
            SizedBox(
              height: _size.height * 0.02,
            ),
            customRadioListTile(
              context,
              _settingsProvider,
              'Enable Sounds',
              _settingsProvider.sounds[0],
              (value) {
                _settingsProvider.switchSounds(value);
              },
            ),
            customRadioListTile(
              context,
              _settingsProvider,
              'Enable General sound',
              _settingsProvider.sounds[0] ? _settingsProvider.sounds[1] : false,
              (value) {
                _settingsProvider.switchGeneralSound(value);
              },
            ),
            customRadioListTile(
              context,
              _settingsProvider,
              'Enable Start game sound',
              _settingsProvider.sounds[0] ? _settingsProvider.sounds[2] : false,
              (value) {
                _settingsProvider.switchStartGameSound(value);
              },
            ),
            customRadioListTile(
              context,
              _settingsProvider,
              'Enable Score board sound',
              _settingsProvider.sounds[0] ? _settingsProvider.sounds[3] : false,
              (value) {
                _settingsProvider.switchScoreBoardSound(value);
              },
            ),
            customRadioListTile(
              context,
              _settingsProvider,
              'Enable Correct Answer sound',
              _settingsProvider.sounds[0] ? _settingsProvider.sounds[4] : false,
              (value) {
                _settingsProvider.switchCorrectAnswerSound(value);
              },
            ),
            customRadioListTile(
              context,
              _settingsProvider,
              'Enable Wrong Answer sound',
              _settingsProvider.sounds[0] ? _settingsProvider.sounds[5] : false,
              (value) {
                _settingsProvider.switchWrongAnswerSound(value);
              },
            ),
            customRadioListTile(
              context,
              _settingsProvider,
              'Enable InGame Clear sound',
              _settingsProvider.sounds[0] ? _settingsProvider.sounds[6] : false,
              (value) {
                _settingsProvider.switchInGameClearSound(value);
              },
            ),
            SizedBox(
              height: _size.height * 0.03,
            ),
            Text(
              'Themes',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: _size.height * 0.02,
            ),
            SizedBox(
              width: 70,
              height: 70,
              child: Center(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _settingsProvider.themes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playScoreBoardSound(_settingsProvider.sounds[3]);
                            _settingsProvider.changeCurrentTheme(index);
                          },
                          onLongPress: () {
                            // TODO: add alert dialog to ask user if he wanna delete the theme
                            _settingsProvider.deleteTheme(index);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _settingsProvider.themes[index][0],
                                      width: 20),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                width: 60,
                                height: 60,
                                // color: _settingsProvider.themes[index]![0],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _settingsProvider.themes[index][1],
                                      width: 20),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                width: 30,
                                height: 30,
                                // color: _settingsProvider.themes[index]![1],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _settingsProvider.themes[index][2],
                                      width: 10),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                width: 15,
                                height: 15,
                                // color: _settingsProvider.themes[index]![2],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _settingsProvider.themes[index][3],
                                      width: 4),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                width: 7.5,
                                height: 7.5,
                                // color: _settingsProvider.themes[index]![3],
                              ),
                            ],
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
            SizedBox(
              height: _size.height * 0.02,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  _settingsProvider.addNewTheme([
                    await showColorPicker(context, watch, 3),
                    await showColorPicker(context, watch, 2),
                    await showColorPicker(context, watch, 1),
                    await showColorPicker(context, watch, 0),
                  ]);
                },
                child: Text(
                  'Add custom theme',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            )
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
