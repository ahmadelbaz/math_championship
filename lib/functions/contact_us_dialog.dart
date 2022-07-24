import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../widgets/custom_alert_dialog.dart';

// Method for sending an email using title and subject used enters then navigate to email app on user's device
Future<void> _sendEmail() async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: myEmail,
    query: encodeQueryParameters(
      <String, String>{
        'subject': '',
        'body': '',
      },
    ),
  );
  launchUrl(emailLaunchUri, mode: LaunchMode.platformDefault);
}

// Method for dialing a number, it navigates to dial with the given number.
Future<void> _dialNumber() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'tel',
    path: myFirstNumber,
  );
  launchUrl(emailLaunchUri, mode: LaunchMode.platformDefault);
}

// Method for alert dialog when user click on contact us button (inside about us screen)
contactUsAlertDialog(BuildContext context) {
  final settingsProvider = context.read(settingsChangeNotifierProvider);
  customAlertDialog(
    const Text('Contact us'),
    Column(
      children: [
        ListTile(
          onTap: _sendEmail,
          leading: Icon(
            Icons.email_rounded,
            color: settingsProvider.currentTheme[0],
          ),
          title: Text(
            'Email',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        ListTile(
          onTap: _dialNumber,
          leading: Icon(
            Icons.phone,
            color: settingsProvider.currentTheme[0],
          ),
          title: Text(
            'Phone',
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
    height: deviceHeight * 0.35,
  );
}
