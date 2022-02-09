
class FormValidator {
  static bool validateName(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    }
    // Regex for email validation
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool validatePassword(String value) {
    if (value.isEmpty) {
      return false;
    }
    // Use any password length of your choice here
    if (value.length < 5) {
      return false;
    }

    return true;
  }
}

class Validator {
  Validator();

  String email(String value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter valid email.';
    else
      return '';
  }
  String allok(String value) {
    
      return '';
  }

  String password(String value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'validator.password';
    else
      return '';
  }

  String name(String value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter name';
    else
      return '';
  }

  String fname(String value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter first name';
    else
      return '';
  }

  String lname(String value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter last name';
    else
      return '';
  }

  String number(String value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'validator.number';
    else
      return '';
  }

  String otp(String? value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';

    RegExp regex = RegExp(pattern);
    if (value == '') {
      return 'Please enter OTP';
    } else if (value!.length < 4)
      return 'Please enter valid OTP';
    else
      return '';
  }

  String mobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern);
    if (value == '') {
      return 'Please enter mobile number.';
    } else if (!regex.hasMatch(value))
      return 'Please enter valid mobile number.';
    else
      return '';
  }

  String amount(String value) {
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'validator.amount';
    else
      return '';
  }

  String notEmpty(String value) {
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'validator.notEmpty';
    else
      return '';
  }
}
