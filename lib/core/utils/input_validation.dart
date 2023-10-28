class InputValidator {
  static String? name(String? value) {
    if (value != null) {
      String pattern = r'^[a-z A-Z]+$';
      RegExp regex = RegExp(pattern);
      if (value.isEmpty) {
        return 'Name is required';
      } else if (!regex.hasMatch(value)) {
        return 'Enter only characters';
      } else if (value.length > 45) {
        return 'Max 45 characters req.';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static String? email(String? value) {
    if (value != null) {
      bool validEmail = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (value.isEmpty) {
        return 'Email is required';
      } else if (validEmail) {
        return null;
      } else {
        return 'Invalid email address';
      }
    }
    return null;
  }

  static String? password(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Password is required';
      } else if (value.length < 6) {
        return 'minimum 6 characters required';
      } else {
        return null;
      }
    }
    return null;
  }

  static String? confirmPassword(String? value, String? enteredPassword) {
    if (value == null || enteredPassword == null) {
      return null;
    } else if (value.isEmpty) {
      return 'Password is required';
    } else if (value != enteredPassword) {
      return "password doesn't match";
    } else if (value.length < 6) {
      return 'minimum 6 characters required';
    } else {
      return null;
    }
  }

  static String? phone(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return 'Mobile number is required';
    } else if (value.length < 10) {
      return 'Mobile number required at least 10 numbers';
    } else if (value.length > 12) {
      return 'Mobile number required at most 12 numbers';
    } else {
      return null;
    }
  }
}
