import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../widgets/custom_app_bar.dart';

class AboutUsScreen extends ConsumerWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final size = MediaQuery.of(context).size;
    final settingsProvider = watch(settingsChangeNotifierProvider);
    return Scaffold(
      backgroundColor: settingsProvider.currentTheme[0],
      appBar: customAppBar(context, settingsProvider, 'About Us'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            const Text('Math Championship is ...')
          ],
        ),
      ),
    );
  }
}
