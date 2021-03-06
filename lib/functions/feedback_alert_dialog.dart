import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_championship/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../widgets/custom_alert_dialog.dart';

// We call this method when user click on feedback button (inside about us screen)
feedbackAlertDialog(BuildContext context) {
  // We create text editing controller to control text fields
  final TextEditingController subject = TextEditingController();
  final TextEditingController body = TextEditingController();
  // we use this node to easily tavel from textfield to another
  final feedbackFocusNode = FocusNode();
  // Creating an instance from settings provider
  final settingsProvider = context.read(settingsChangeNotifierProvider);
  customAlertDialog(
    const Text('Feedback'),
    Column(
      children: [
        TextField(
          style: TextStyle(
            color: settingsProvider.currentTheme[0],
            fontFamily: settingsProvider.secondaryFont,
          ),
          cursorColor: settingsProvider.currentTheme[0],
          controller: subject,
          keyboardType: TextInputType.text,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Subject',
            labelStyle: TextStyle(
              color: settingsProvider.currentTheme[0],
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                color: settingsProvider.currentTheme[0],
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                color: settingsProvider.currentTheme[0],
              ),
            ),
            prefixIcon: Icon(
              Icons.email_rounded,
              color: settingsProvider.currentTheme[0],
            ),
          ),
          onSubmitted: (_) {
            // Move to next text field
            feedbackFocusNode.requestFocus();
          },
        ),
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        TextField(
          focusNode: feedbackFocusNode,
          style: TextStyle(
            color: settingsProvider.currentTheme[0],
            fontFamily: settingsProvider.secondaryFont,
          ),
          cursorColor: settingsProvider.currentTheme[0],
          controller: body,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Feedback',
            labelStyle: TextStyle(
              color: settingsProvider.currentTheme[0],
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                color: settingsProvider.currentTheme[0],
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                color: settingsProvider.currentTheme[0],
              ),
            ),
            prefixIcon: Icon(
              Icons.feedback_rounded,
              color: settingsProvider.currentTheme[0],
            ),
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
          'Cancel',
          style: TextStyle(
            color: settingsProvider.currentTheme[0],
          ),
        ),
      ),
      TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
          // Navigate to mail app to send feedback
          String? encodeQueryParameters(Map<String, String> params) {
            return params.entries
                .map((MapEntry<String, String> e) =>
                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                .join('&');
          }

          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: myEmail,
            query: encodeQueryParameters(
              <String, String>{
                'subject': subject.text,
                'body': body.text,
              },
            ),
          );

          launchUrl(emailLaunchUri, mode: LaunchMode.platformDefault);
          context
              .read(achievementsChangeNotifierProvider)
              .checkAchievement(11, context.read(pointsChangeNotifierProvider));
        },
        child: Text(
          'Send',
          style: TextStyle(
            color: settingsProvider.currentTheme[0],
          ),
        ),
      ),
    ],
    height: deviceHeight * 0.4,
  );
}
