class AppValidator {
  static int phoneLength = 11;
  static int emailLength = 30;
  static int passwordLength = 30;
  static int descriptiveLength = 80;

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter an email address";
    } else {
      if (!(RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value))) {
        return "Invalid Email";
      }
    }
  }

  static String? passValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter a password";
    } else {
      if (!(RegExp(
              r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
          .hasMatch(value))) {
        return "Invalid Password - Password must contain one UpperCase, one LowerCase, one digit, one Special Character and length must be 8";
      }
    }
  }
}
