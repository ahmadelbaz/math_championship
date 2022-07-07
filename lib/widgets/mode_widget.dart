import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/customize_date.dart';
import '../main.dart';
import '../screens/start_screen.dart';

class ModeWidget extends ConsumerWidget {
  final int index;
  final VoidCallback widgetTapped;

  const ModeWidget(
    this.index,
    this.widgetTapped,
  );

  @override
  Widget build(BuildContext context, watch) {
    // needed modes provider
    final _modesProvider = watch(modesChangeNotifierProvider);
    final _settingsProvider = watch(settingsChangeNotifierProvider);
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _size.width * 0.06),
      child: InkWell(
        highlightColor: Colors.grey,
        onTap: widgetTapped,
        child: Container(
          height: _size.height * 0.2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(_size.width * 0.06),
            ),
          ),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  _modesProvider.modes[index].name,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: _size.height * 0.03,
              ),
              _modesProvider.modes[index].locked == 1
                  ? Icon(
                      Icons.lock,
                      color: _settingsProvider.currentTheme[0],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: _size.width * 0.03,
                            ),
                            const Image(
                              image: AssetImage('assets/images/score.png'),
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: _size.width * 0.03,
                            ),
                            Text(
                              '${_modesProvider.modes[index].highScore}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ), // headline5
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            customizeDate(
                                _modesProvider.modes[index].highScoreDateTime),
                            style: _modesProvider.modes[index].highScore == 0
                                ? TextStyle(
                                    color: Theme.of(context).primaryColor)
                                : Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
