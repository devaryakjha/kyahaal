class InputFieldValidators {
  static String? phone(String? value) {
    if (value == null || value.isEmpty || value.length != 10) {
      return 'Please enter a valid Phone Number';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid Name';
    }
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.isEmpty || value.length != 6) {
      return 'Please enter a valid OTP';
    }
    return null;
  }
}
