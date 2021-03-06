import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/functions/contact_us_dialog.dart';
import 'package:math_championship/functions/donation_alert_dialog.dart';
import 'package:math_championship/functions/feedback_alert_dialog.dart';
import 'package:math_championship/screens/introduction_screen.dart';

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
        padding: const EdgeInsets.only(
          right: 28.0,
          left: 28.0,
        ),
        child: ListView(
          // shrinkWrap: true,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Math Championship is an app/game that we develop trying to improve math skills besides having fun.\nThe App still in BETA version and we are trying to improve it more and more.\nIf you want to support us you can',
                style: TextStyle(
                  fontFamily: settingsProvider.secondaryFont,
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            ElevatedButton(
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
                feedbackAlertDialog(context);
              },
              child: const FittedBox(
                child: Text(
                  'Give us feedback',
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            ElevatedButton(
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
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            ElevatedButton(
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
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            ElevatedButton(
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
                contactUsAlertDialog(context);
              },
              child: const FittedBox(
                child: Text(
                  'Contact us',
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.2,
            ),
            TextButton(
              onPressed: () {
                playGeneralSound(settingsProvider.sounds[1]);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const OnBoardingPage()),
                );
              },
              child: FittedBox(
                child: Text(
                  'Tutorial >>',
                  style: TextStyle(
                      fontSize: 35, color: settingsProvider.currentTheme[2]),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
