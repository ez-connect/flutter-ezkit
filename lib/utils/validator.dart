class Validator {
  static String? empty(String? label, String? value) {
    if (value == null || value.isEmpty) {
      return '$label không được để trống';
    }
    return null;
  }

  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email không được để trống';
    }

    final regex = RegExp(
      r'^[a-z][a-z0-9_\.]{1,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$',
    );
    if (regex.hasMatch(email)) {
      return null;
    }

    return 'Email sai';
  }

  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
   
    return null;
  }

  static String? phone(String? phone,{bool isRequired = false}) {
    if (phone == null || phone.isEmpty) {
      if(isRequired){
        return 'Số điện thoại không được để trống';
      }
       return null; 
      }
   
    // check phone format
    final regex = RegExp(r'^(84|0[3|5|7|8|9])+([0-9]{8})\b');
    if (regex.hasMatch(phone)) {
      return null;
    }

    return 'Số điện thoại sai';
  }
}
