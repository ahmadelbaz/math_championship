import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/functions/donation_alert_dialog.dart';

import '../functions/play_sounds.dart';
import '../main.dart';
import '../widgets/custom_app_bar.dart';

class AboutUsScreen extends ConsumerWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final size = MediaQuery.of(context).size;
    final settingsProvider = watch(settingsChangeNotifierProvider);
    return Scaffold(
      backgroundColor: settingsProvider.currentTheme[0],
      appBar: customAppBar(context, settingsProvider, 'About Us'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Math Championship is an app/game that we develop trying to improve math skills besides having fun.\nThe App still in BETA version and we are trying to improve it more and more.\nIf you want to support us you can',
              style: TextStyle(
                fontFamily: 'rimouski',
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(size.height * 0.07),
                  primary: Theme.of(context).primaryColor,
                  onPrimary: settingsProvider.currentTheme[0],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  playGeneralSound(settingsProvider.sounds[1]);
                  // Navigator.of(context).pushNamed('/start_screen');
                },
                child: const FittedBox(
                  child: Text(
                    'Give us feedback',
                    style: TextStyle(fontSize: 35),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(size.height * 0.07),
                  primary: Theme.of(context).primaryColor,
                  onPrimary: settingsProvider.currentTheme[0],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  playGeneralSound(settingsProvider.sounds[1]);
                  donationAlertDialog(context);
                },
                child: const FittedBox(
                  child: Text(
                    'Donate',
                    style: TextStyle(fontSize: 35),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(size.height * 0.07),
                  primary: Theme.of(context).primaryColor,
                  onPrimary: settingsProvider.currentTheme[0],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  playGeneralSound(settingsProvider.sounds[1]);
                },
                child: const FittedBox(
                  child: Text(
                    'Rate the game',
                    style: TextStyle(fontSize: 35),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
