import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/main.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final _size = MediaQuery.of(context).size;
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    return Scaffold(
      backgroundColor: _settingsProvider.currentTheme[0],
      body: ListView(
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
          ListTile(
            title: Text(
              'Enable Sounds',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Switch(
              value: _settingsProvider.sounds[0],
              onChanged: (value) {
                _settingsProvider.switchSounds(value);
              },
              activeColor: _settingsProvider.currentTheme[3],
            ),
          ),
          ListTile(
            title: Text(
              'Enable General sound',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[1]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchGeneralSound(value);
              },
              activeColor: _settingsProvider.currentTheme[3],
            ),
          ),
          ListTile(
            title: Text(
              'Enable Start game sound',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[2]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchStartGameSound(value);
              },
              activeColor: _settingsProvider.currentTheme[3],
            ),
          ),
          ListTile(
            title: Text(
              'Enable Score board sound',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[3]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchScoreBoardSound(value);
              },
              activeColor: _settingsProvider.currentTheme[3],
            ),
          ),
          ListTile(
            title: Text(
              'Enable Correct Answer sound',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[4]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchCorrectAnswerSound(value);
              },
              activeColor: _settingsProvider.currentTheme[3],
            ),
          ),
          ListTile(
            title: Text(
              'Enable Wrong Answer sound',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[5]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchWrongAnswerSound(value);
              },
              activeColor: _settingsProvider.currentTheme[3],
            ),
          ),
          ListTile(
            title: Text(
              'Enable InGame Clear sound',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Switch(
              value: _settingsProvider.sounds[0]
                  ? _settingsProvider.sounds[6]
                  : false,
              onChanged: (value) {
                _settingsProvider.switchInGameClearSound(value);
              },
              activeColor: _settingsProvider.currentTheme[3],
              // inactiveThumbColor: Colors.yellow,
              // inactiveTrackColor: ,
            ),
          ),
          SizedBox(
            height: _size.height * 0.03,
          ),
          Text(
            'Theme',
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
                          _settingsProvider.changeCurrentTheme(index);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              color: _settingsProvider.themes[index]![0],
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: _settingsProvider.themes[index]![1],
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              color: _settingsProvider.themes[index]![3],
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
        ],
      ),
    );
  }
}
