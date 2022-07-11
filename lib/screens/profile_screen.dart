import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/screens/welcome_screen.dart';
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
    // var _futureProvider = watch(userFutureProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: settingsProvider.currentTheme[0],
        elevation: 0.0,
        title: Text(
          userProvider.getUser().name,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      backgroundColor: settingsProvider.currentTheme[0],
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
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
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
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
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.25,
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
                      } else if (nameController.text == 'gguest') {
                        customSnackBar('Enter another name');
                      } else {
                        userProvider.updateUserName(nameController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
