class Validator {
  static String? emailValidate(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return "Not a valid email. Should be your@email.com";
    } else {
      return null;
    }
  }

  static String? passValidate(String? value) {
    if (value!.isEmpty) {
      return "Password should not be empty";
    } else if (value.length < 6) {
      return "Password should be greater than 6 character";
    } else {
      return null;
    }
  }

  static String? nameValidate(String? value) {
    if (value!.isEmpty) {
      return "User name should not be empty";
    } else if (value.length < 6) {
      return "User name should not be less then 6 character";
    } else if (value.length > 30) {
      return "User name should not be greater then 30 character";
    } else {
      return null;
    }
  }

  Validator._();
}
