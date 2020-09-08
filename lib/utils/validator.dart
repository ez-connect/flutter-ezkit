class Validator {
  static String empty(String label, String value) {
    if (value == null || value.isEmpty) {
      return '$label cannot be empty';
    }
    return null;
  }

  static String email(String email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }

    final regex = RegExp(
      r'^[a-z][a-z0-9_\.]{1,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$',
    );
    if (regex.hasMatch(email)) {
      return null;
    }

    return 'Email wrong';
  }

  static String password(String password) {
    if (password == null || password.isEmpty) {
      return 'password cannot be empty';
    }
    return null;
  }

  static String phone(String phone, {bool isRequired = false}) {
    if (phone == null || phone.isEmpty) {
      if (isRequired) {
        return 'Phone cannot be empty';
      } else {
        return null;
      }
    }

    // check phone format
    final regex = RegExp(r'^[0-9]{10}$');
    if (regex.hasMatch(phone)) {
      return null;
    }

    return 'Phone wrong';
  }
}
