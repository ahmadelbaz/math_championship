import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

// because we have a lot of snackbars in the app
// we take it as separated function and call it when it's needed
void customAlertDialog(Widget title, Widget content, List<Widget> actions) {
  // we get context ftom globalKey to use it here
  BuildContext? context = navigatorKey.currentContext;

  final _settingsProvider = context!.read(settingsChangeNotifierProvider);
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: title,
      content: content,
      actions: actions,
    ),
  );
}