class Validators {

  static final RegExp _regExp = RegExp(
    r'^.{8,}$',
  );


  static isValidUsername(String username) {
    return _regExp.hasMatch(username);
  }

  static isValidPassword(String password) {
    return _regExp.hasMatch(password);
  }

}