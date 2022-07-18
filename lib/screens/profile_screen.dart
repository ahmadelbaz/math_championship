import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/screens/welcome_screen.dart';
import 'package:math_championship/widgets/custom_app_bar.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';

import '../functions/play_sounds.dart';
import '../main.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context, watch) {
    final size = MediaQuery.of(context).size;
    var userProvider = watch(userChangeNotifierProvider);
    final settingsProvider = watch(settingsChangeNotifierProvider);
    final achievementProvider = watch(achievementsChangeNotifierProvider);
    final pointsProvider = watch(pointsChangeNotifierProvider);
    nameController.text = userProvider.getUser().name;
    nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length));
    // var _futureProvider = watch(userFutureProvider);
    return Scaffold(
      backgroundColor: settingsProvider.currentTheme[0],
      appBar:
          customAppBar(context, settingsProvider, userProvider.getUser().name),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: TextStyle(color: settingsProvider.currentTheme[1]),
                controller: nameController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                // autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  prefixIcon: Icon(
                    Icons.supervised_user_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(size.height * 0.07),
                  primary: Theme.of(context).primaryColor,
                  onPrimary: settingsProvider.currentTheme[0],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  playGeneralSound(settingsProvider.sounds[1]);
                  if (nameController.text.isEmpty) {
                    customSnackBar('Please enter a name');
                    //this needs to be fixed it should be 'guest' not 'gguest'
                  } else if (nameController.text == 'guest') {
                    customSnackBar('Enter another name');
                  } else {
                    userProvider.updateUserName(achievementProvider,
                        nameController.text, pointsProvider);
                    nameController.text = '';
                    // Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Achievements'),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: achievementProvider.achievements.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          achievementProvider.achievements[index].task,
                          style: TextStyle(
                            fontFamily: settingsProvider.secondaryFont,
                            fontSize: 18,
                            color: settingsProvider.currentTheme[1],
                            decoration:
                                achievementProvider.achievements[index].hasDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                          ),
                        ),
                        Icon(
                          achievementProvider.achievements[index].hasDone
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: settingsProvider.currentTheme[1],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
