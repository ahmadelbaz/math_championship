import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

// because we have a lot of snackbars in the app
// we take it as separated function and call it when it's needed
void customSnackBar(String content) {
  // we get context ftom globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;

  // we want to remove any snackbar on screen if a new snackbar is coming
  ScaffoldMessenger.of(context!).removeCurrentSnackBar();
  final settingsProvider = context.read(settingsChangeNotifierProvider);
  final snackBar = SnackBar(
    content: Text(
      content,
      style: TextStyle(
          fontFamily: settingsProvider.mainFont,
          color: settingsProvider.currentTheme[0]),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Theme.of(context).primaryColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
