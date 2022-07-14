import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:math_championship/widgets/custom_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../widgets/custom_alert_dialog.dart';

final Uri _paybalUrl = Uri.parse('http://paypal.me/ahmadelbazdev');

Future<void> _launchUrl() async {
  if (!await launchUrl(_paybalUrl,
      mode: LaunchMode.externalNonBrowserApplication)) {
    throw 'Could not launch $_paybalUrl';
  }
}

donationAlertDialog(BuildContext context) {
  final settingsProvider = context.read(settingsChangeNotifierProvider);
  customAlertDialog(
    const Text('Donate'),
    Column(
      children: [
        TextButton.icon(
          onPressed: _launchUrl,
          icon: Icon(
            Icons.paypal_outlined,
            color: settingsProvider.currentTheme[0],
          ),
          label: Text(
            'Paybal',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        TextButton.icon(
          onPressed: () {
            Clipboard.setData(
              const ClipboardData(
                text: "+201010825280",
              ),
            );
            Navigator.of(context).pop();
            customSnackBar('Copied to Clipboard');
          },
          icon: Icon(
            Icons.money_rounded,
            color: settingsProvider.currentTheme[0],
          ),
          label: Text(
            'Vodafone cash',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        TextButton.icon(
          onPressed: () {
            Clipboard.setData(
              const ClipboardData(
                text: "+201145009965",
              ),
            );
            Navigator.of(context).pop();
            customSnackBar('Copied to Clipboard');
          },
          icon: Icon(
            Icons.money_rounded,
            color: settingsProvider.currentTheme[0],
          ),
          label: Text(
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
    height: deviceHeight * 0.4,
  );
}
