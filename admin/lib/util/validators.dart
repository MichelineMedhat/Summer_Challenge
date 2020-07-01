class Validators {
  static final RegExp _scoreRegExp = RegExp(
    r'^[0-9]*$',
  );

  static isValidScore(String score) {
    return _scoreRegExp.hasMatch(score);
  }
}
