import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Sound effects'),
              // there is more to add here
            ],
          ),
          SizedBox(
            height: _size.height * 0.2,
          ),
          Text(
            'Theme',
            style: Theme.of(context).textTheme.headline2,
          ),
          // there is more to add hered
        ],
      ),
    );
  }
}
