import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../widgets/custom_alert_dialog.dart';

final Uri _paybalUrl = Uri.parse(myPaybal);

// Method to open any link in external browser in user device
Future<void> _launchUrl() async {
  if (!await launchUrl(
    _paybalUrl,
    mode: LaunchMode.externalNonBrowserApplication,
  )) {
    throw 'Could not launch $_paybalUrl';
  }
}

// Method for alert dialog that appears when user click on donation button (inside about us screen)
donationAlertDialog(BuildContext context) {
  final settingsProvider = context.read(settingsChangeNotifierProvider);
  customAlertDialog(
    const Text('Donate'),
    Column(
      children: [
        ListTile(
          onTap: _launchUrl,
          leading: Icon(
            Icons.paypal_outlined,
            color: settingsProvider.currentTheme[0],
          ),
          title: Text(
            'Paybal',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        ListTile(
          onTap: () {
            Clipboard.setData(
              const ClipboardData(
                text: mySecondNumber,
              ),
            );
            Navigator.of(context).pop();
            // When user click on the number it gets copied in clipboard
            customSnackBar('Copied to Clipboard');
          },
          leading: Icon(
            Icons.money_rounded,
            color: settingsProvider.currentTheme[0],
          ),
          title: Text(
            'Vodafone cash',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        ListTile(
          onTap: () {
            Clipboard.setData(
              const ClipboardData(
                text: myFirstNumber,
              ),
            );
            Navigator.of(context).pop();
            customSnackBar('Copied to Clipboard');
          },
          leading: Icon(
            Icons.money_rounded,
            color: settingsProvider.currentTheme[0],
          ),
          title: Text(
            'Etisalat cash',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    ),
    [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Got it',
          style: TextStyle(
            color: settingsProvider.currentTheme[0],
          ),
        ),
      ),
    ],
    height: deviceHeight * 0.5,
  );
}
