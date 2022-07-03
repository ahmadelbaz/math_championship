import 'package:flutter/material.dart';

import '../providers/settings_provider.dart';

Widget customRadioListTile(
    BuildContext context,
    SettingsProvider _settingsProvider,
    String radioText,
    bool radioValue,
    Function? Function(bool value) radioChanged) {
  return ListTile(
    title: Text(
      radioText,
      style: TextStyle(color: Theme.of(context).primaryColor),
    ),
    trailing: Switch(
      value: radioValue,
      onChanged: radioChanged,
      activeColor: _settingsProvider.currentTheme[3],
    ),
  );
}
