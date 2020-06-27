class Validators {

  static final RegExp _passwrodRegExp = RegExp(
    r'^.{8,}$',
  );


  static final RegExp _phoneNumberRegExp = RegExp(
     r'^\d{11}$',
  );

  static final RegExp _userNameRegExp = RegExp(
      r'^.{5,}$',
  );
  static isValidUsername(String username) {
    return _userNameRegExp.hasMatch(username);
  }

  static isValidPassword(String password) {
    return _passwrodRegExp.hasMatch(password);
  }

  static isValidPhoneNumber(String phoneNumber){
    return _phoneNumberRegExp.hasMatch(phoneNumber);
  }

}