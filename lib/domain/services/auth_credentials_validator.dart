class AuthCredentialValidator {
  bool isEmailValid(String email) {
    final parts = email.split('@');

    if (parts.length != 2) {
      return false;
    }

    final username = parts[0];
    final domain = parts[1];

    return username.isNotEmpty &&
        domain.isNotEmpty &&
        domain.contains('.') &&
        !domain.startsWith('.') &&
        !domain.endsWith('.');
  }

  bool isPasswordValid(String password) {
    return password.length >= 8;
  }
}
