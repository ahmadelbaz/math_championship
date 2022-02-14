import 'package:flutter/material.dart';

class ModeWidget extends StatelessWidget {
  final VoidCallback widgetTapped;
  final String modeName;
  final int modeHighScore;
  final DateTime highScoreDateTime;

  const ModeWidget(this.widgetTapped, this.modeName, this.modeHighScore,
      this.highScoreDateTime);

  @override
  Widget build(BuildContext context) {
    String hourIn12System = '${highScoreDateTime.hour}';
    String day = highScoreDateTime.day < 10
        ? '0${highScoreDateTime.day}'
        : '${highScoreDateTime.day}';
    String month = highScoreDateTime.month < 10
        ? '0${highScoreDateTime.month}'
        : '${highScoreDateTime.month}';
    String amOrPm = '';
    String minutes = '${highScoreDateTime.minute}';
    String seconds = '${highScoreDateTime.second}';
    if (highScoreDateTime.hour > 12) {
      amOrPm = 'pm';
      hourIn12System = '${highScoreDateTime.hour - 12}';
    } else if (highScoreDateTime.hour == 00) {
      amOrPm = 'am';
      hourIn12System = '12';
    } else if (highScoreDateTime.hour == 12) {
      amOrPm = 'pm';
    } else {
      amOrPm = 'am';
      hourIn12System = '${highScoreDateTime.hour}';
    }
    if (int.parse(hourIn12System) < 10) {
      hourIn12System = '0$hourIn12System';
    }
    if (highScoreDateTime.minute < 10) {
      minutes = '0${highScoreDateTime.minute}';
    }
    if (highScoreDateTime.second < 10) {
      seconds = '0${highScoreDateTime.second}';
    }
    String date =
        '${highScoreDateTime.year}/$month/$day\n$hourIn12System:$minutes:$seconds $amOrPm';
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _size.width * 0.06),
      child: InkWell(
        highlightColor: Colors.grey,
        onTap: widgetTapped,
        child: Container(
          height: _size.height * 0.2,
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
                  modeName,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: _size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: _size.width * 0.03,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: _size.width * 0.03,
                      ),
                      Text(
                        '$modeHighScore',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ), // headline5
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        date,
                        style: modeHighScore == 0
                            ? TextStyle(color: Theme.of(context).primaryColor)
                            : Theme.of(context).textTheme.headline3,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
