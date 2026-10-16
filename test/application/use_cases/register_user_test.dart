import 'package:credit_analysis_app/application/use_cases/register_user.dart';
import 'package:credit_analysis_app/domain/repositories/auth_repository.dart';
import 'package:credit_analysis_app/domain/services/auth_credentials_validator.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthRepository implements AuthRepository {
  String? registeredEmail;
  String? registeredPassword;

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    registeredEmail = email;
    registeredPassword = password;
  }
}

void main() {
  test('registra credenciales válidas usando el repositorio', () async {
    final repository = FakeAuthRepository();
    final useCase = RegisterUser(
      repository: repository,
      validator: AuthCredentialValidator(),
    );

    await useCase.execute(email: 'usuario@example.com', password: '12345678');

    expect(repository.registeredEmail, 'usuario@example.com');
    expect(repository.registeredPassword, '12345678');
  });
  test("no registra cuando el correo electrónico es inválido", () async {
    final repository = FakeAuthRepository();
    final useCase = RegisterUser(
      repository: repository,
      validator: AuthCredentialValidator(),
    );

    await expectLater(
      useCase.execute(email: 'usuario-invalido', password: '12345678'),
      throwsArgumentError,
    );

    expect(repository.registeredEmail, isNull);
    expect(repository.registeredPassword, isNull);
  });

  test("no registra cuando la contraseña es inválida", () async {
    final repository = FakeAuthRepository();
    final useCase = RegisterUser(
      repository: repository,
      validator: AuthCredentialValidator(),
    );

    await expectLater(
      useCase.execute(email: 'usuario@example.com', password: '1234567'),
      throwsArgumentError,
    );

    expect(repository.registeredEmail, isNull);
    expect(repository.registeredPassword, isNull);
  });
}
