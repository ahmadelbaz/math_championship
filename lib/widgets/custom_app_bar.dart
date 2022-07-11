import 'package:flutter/material.dart';

import '../providers/settings_provider.dart';

PreferredSizeWidget customAppBar(
    BuildContext context, SettingsProvider settingsProvider, String title) {
  return AppBar(
    leading: BackButton(color: Theme.of(context).primaryColor),
    title: Text(
      title,
      style: TextStyle(color: Theme.of(context).primaryColor),
    ),
    centerTitle: true,
    backgroundColor: settingsProvider.currentTheme[0],
    elevation: 0,
  );
}
