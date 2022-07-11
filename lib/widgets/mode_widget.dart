import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/customize_date.dart';
import '../main.dart';

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
    final modesProvider = watch(modesChangeNotifierProvider);
    final settingsProvider = watch(settingsChangeNotifierProvider);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: InkWell(
        highlightColor: Colors.grey,
        onTap: widgetTapped,
        child: Container(
          height: size.height * 0.2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(size.width * 0.06),
            ),
          ),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  modesProvider.modes[index].name,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              modesProvider.modes[index].locked == 1
                  ? Icon(
                      Icons.lock,
                      color: settingsProvider.currentTheme[0],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            const Image(
                              image: AssetImage('assets/images/score.png'),
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              '${modesProvider.modes[index].highScore}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ), // headline5
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            modesProvider.modes[index].highScore == 0
                                ? 'No high score'
                                : customizeDate(modesProvider
                                    .modes[index].highScoreDateTime),
                            style: Theme.of(context).textTheme.headline3,
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
