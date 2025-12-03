
bool _isNullOrEmpty(String? value) {
  return value == null || value.trim().isEmpty;
}

bool isValidEmailFormat(String email) {
  return RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$",
  ).hasMatch(email.trim());
}

bool isValidPhoneFormat(String phone, {int length = 11}) {
  return RegExp(r"^[0-9]+$").hasMatch(phone.trim()) &&
      phone.trim().length == length;
}

String? validateRequired(String? value, {String fieldName = 'this field'}) {
  if (_isNullOrEmpty(value)) {
    return 'Please enter $fieldName';
  }
  return null;
}

String? validateName(String? value, {String fieldName = 'name'}) {
  if (_isNullOrEmpty(value)) {
    return 'Please enter $fieldName';
  }

  final trimmed = value!.trim();

  if (trimmed.length < 2) {
    return '$fieldName must be at least 2 characters';
  }

  if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(trimmed)) {
    return '$fieldName should contain letters only';
  }

  return null;
}

String? validateEmail(String? value) {
  if (_isNullOrEmpty(value)) {
    return 'Please enter email';
  }

  if (!isValidEmailFormat(value!)) {
    return 'Please enter valid email';
  }

  return null;
}

String? validatePhone(String? value) {
  if (_isNullOrEmpty(value)) {
    return 'Please enter phone number';
  }

  if (!isValidPhoneFormat(value!, length: 11)) {
    return 'Phone must be 11 digits';
  }

  return null;
}

String? validatePassword(String? value, {int minLength = 6}) {
  if (_isNullOrEmpty(value)) {
    return 'Please enter password';
  }

  if (value!.length < minLength) {
    return 'Password must be at least $minLength characters';
  }



  return null;
}

String? validateConfirmPassword(String? value, String originalPassword) {
  if (_isNullOrEmpty(value)) {
    return 'Please re-type password';
  }

  if (value != originalPassword) {
    return 'Password does not match';
  }

  return null;
}
