String customizeDate(DateTime highScoreDateTime) {
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
  return date;
}
