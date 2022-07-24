import 'dart:math';

// Method to generate random number, we use it in all modes
int generateRandomNum(int min, int max) {
  Random r = Random();
  return min + r.nextInt(max);
}

// method to generate random sign
String generateRandomSign() {
  List<String> signs = ['+', '-', 'X', '/'];
  return signs[generateRandomNum(0, 4)];
}
