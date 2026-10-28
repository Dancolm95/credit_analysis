import '../../domain/repositories/auth_repository.dart';
import '../../domain/services/auth_credentials_validator.dart';

class LoginUser {
  final AuthRepository repository;
  final AuthCredentialValidator validator;

  LoginUser({required this.repository, required this.validator});

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    if (!validator.isEmailValid(email)) {
      throw ArgumentError('El correo electrónico no es válido.');
    }

    if (!validator.isPasswordValid(password)) {
      throw ArgumentError('La contraseña debe tener al menos 8 caracteres.');
    }

    await repository.signIn(email: email, password: password);
  }
}
