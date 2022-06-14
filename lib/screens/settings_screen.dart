import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/main.dart';

import '../constants.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    return Scaffold(
      backgroundColor: kMainColor,
      body: ListView(
        children: [
          SizedBox(
            height: _size.height * 0.02,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Sound effects'),
              // there is more to add here
            ],
          ),
          SizedBox(
            height: _size.height * 0.02,
          ),
          ListTile(
            title: const Text('Enable Sounds'),
            trailing: Switch(
              value: _settingsProvider.sounds[0],
              onChanged: (value) {
                _settingsProvider.switchSounds(value);
              },
              activeColor: primaryColor,
            ),
          ),
          ListTile(
            title: const Text('Enable General sound'),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[1]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchGeneralSound(value);
              },
              activeColor: primaryColor,
            ),
          ),
          ListTile(
            title: const Text('Enable Start game sound'),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[2]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchStartGameSound(value);
              },
              activeColor: primaryColor,
            ),
          ),
          ListTile(
            title: const Text('Enable Score board sound'),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[3]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchScoreBoardSound(value);
              },
              activeColor: primaryColor,
            ),
          ),
          ListTile(
            title: const Text('Enable Correct Answer sound'),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[4]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchCorrectAnswerSound(value);
              },
              activeColor: primaryColor,
            ),
          ),
          ListTile(
            title: const Text('Enable Wrong Answer sound'),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[5]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchWrongAnswerSound(value);
              },
              activeColor: primaryColor,
            ),
          ),
          ListTile(
            title: const Text('Enable InGame Clear sound'),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[6]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchInGameClearSound(value);
              },
              activeColor: primaryColor,
            ),
          ),

          SizedBox(
            height: _size.height * 0.2,
          ),
          Text(
            'Theme',
            style: Theme.of(context).textTheme.headline2,
          ),
          // there is more to add hered
        ],
      ),
    );
  }
}
