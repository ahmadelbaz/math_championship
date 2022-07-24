import 'package:flutter/material.dart';
import '../main.dart';

// because we have a lot of snackbars in the app
// we take it as separated function and call it when it's needed
Future<void> customAlertDialog(
    Widget title, Widget content, List<Widget> actions,
    {double height = 0.0,
    bool hasBackColor = false,
    bool isFullScreen = false}) async {
  // we get context ftom globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;

  // final settingsProvider = context!.read(settingsChangeNotifierProvider);
  await showDialog(
    context: context!,
    builder: (ctx) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      backgroundColor:
          hasBackColor ? Colors.white : Theme.of(context).primaryColor,
      title: title,
      content: height != 0.0
          ? SizedBox(
              height: height,
              child: content,
            )
          : content,
      actions: actions,
    ),
  );
}
