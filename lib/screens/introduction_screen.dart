import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:math_championship/functions/play_sounds.dart';
import 'package:math_championship/main.dart';
import 'package:math_championship/screens/welcome_screen.dart';

import '../providers/settings_provider.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context, SettingsProvider settingsProvider) {
    playGeneralSound(settingsProvider.sounds[1]);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WelcomeScreen()),
    );
  }

  Widget _buildImage(String assetName, Color borderColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 3,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: Image.asset(
              'assets/images/$assetName',
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.read(settingsChangeNotifierProvider);
    final size = MediaQuery.of(context).size;
    var bodyStyle = TextStyle(
        fontSize: 19.0,
        color: Theme.of(context).primaryColor,
        fontFamily: settingsProvider.secondaryFont);
    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).primaryColor),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: settingsProvider.currentTheme[0],
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: settingsProvider.currentTheme[0],
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FittedBox(
                child: Text('Welcome to Math Championship',
                    style: TextStyle(color: Theme.of(context).primaryColor))),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromHeight(size.height * 0.07),
            primary: Theme.of(context).primaryColor,
            onPrimary: settingsProvider.currentTheme[0],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context, settingsProvider),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Create a profile",
          body:
              "First, Create a profile (if you want) by adding your name and click save.",
          image: _buildImage('profile.jpg', settingsProvider.currentTheme[1]),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Modes to play",
          body:
              "There are some modes that you can play. Some of them are available and the rest are locked and you can unlock them with Math Coins.",
          image: _buildImage('start.jpg', settingsProvider.currentTheme[1]),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Playing a game",
          body:
              "You gain Math Points by answering problems. If the answer is more than one digit you can see it below the question and you can also delete what you typed with the 'clear' button.",
          image: _buildImage('game.jpg', settingsProvider.currentTheme[1]),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Settings",
          body:
              "In settings you can edit sounds and change the theme.\nYou can also add your custom theme.",
          image: _buildImage('settings.jpg', settingsProvider.currentTheme[1]),
          decoration: pageDecoration,
        ),
        // PageViewModel(
        //   title: "Settings",
        //   body:
        //       "In settings you can edit sounds and change the theme.\nYou can also add your custom theme.",
        //   image: _buildImage('settings.jpg'),
        //   decoration: pageDecoration.copyWith(
        //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
        //     fullScreen: true,
        //     bodyFlex: 2,
        //     imageFlex: 3,
        //   ),
        // ),
        PageViewModel(
          title: "Math Points & Coins",
          body:
              "Math Points can only be earned by playing.\nMath Coins can be earned by playing games, achievements and maybe other ways in the future.",
          image:
              _buildImage('scoreboard.jpg', settingsProvider.currentTheme[1]),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Store",
          body: "From store you can buy new themes and other things.",
          image: _buildImage('store.jpg', settingsProvider.currentTheme[1]),
          decoration: pageDecoration,
          footer: ElevatedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            style: ElevatedButton.styleFrom(
              primary: settingsProvider.currentTheme[1],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Repeat the tutorial',
              style: TextStyle(color: settingsProvider.currentTheme[0]),
            ),
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context, settingsProvider),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Icon(Icons.arrow_back, color: settingsProvider.currentTheme[0]),
      skip: Text('Skip',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: settingsProvider.currentTheme[0])),
      next: Icon(Icons.arrow_forward, color: settingsProvider.currentTheme[0]),
      done: Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: settingsProvider.currentTheme[0])),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: settingsProvider.currentTheme[0],
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: settingsProvider.currentTheme[2],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
