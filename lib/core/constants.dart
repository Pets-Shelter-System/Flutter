// core/constants.dart

/// Email validator
bool isValidEmail(String? email) {
  if (email == null || email.trim().isEmpty) {
    return false;
  }

  return RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(email.trim());
}

/// Phone validator (11 digits)
bool isValidPhone(String? phone) {
  if (phone == null || phone.trim().isEmpty) {
    return false;
  }

  return RegExp(r"^[0-9]{11}$").hasMatch(phone.trim());
}
