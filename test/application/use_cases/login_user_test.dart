import 'package:credit_analysis_app/application/use_cases/login_user.dart';
import 'package:credit_analysis_app/domain/repositories/auth_repository.dart';
import 'package:credit_analysis_app/domain/services/auth_credentials_validator.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthRepository implements AuthRepository {
  String? signedInEmail;
  String? signedInPassword;

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {}

  @override
  Future<void> signIn({required String email, required String password}) async {
    signedInEmail = email;
    signedInPassword = password;
  }
}

void main() {
  test("inicia sesión usando el repositorio", () async {
    final repository = FakeAuthRepository();
    final useCase = LoginUser(
      repository: repository,
      validator: AuthCredentialValidator(),
    );

    await useCase.execute(email: 'usuario@example.com', password: '12345678');

    expect(repository.signedInEmail, 'usuario@example.com');
    expect(repository.signedInPassword, '12345678');
  });

  test("no inicia sesión cuando el correo es inválido", () async {
    final repository = FakeAuthRepository();
    final useCase = LoginUser(
      repository: repository,
      validator: AuthCredentialValidator(),
    );

    await expectLater(
      useCase.execute(email: 'usuario-invalido', password: '12345678'),
      throwsArgumentError,
    );

    expect(repository.signedInEmail, isNull);
    expect(repository.signedInPassword, isNull);
  });

  test('no inicia sesión cuando la contraseña es inválida', () async {
    final repository = FakeAuthRepository();
    final useCase = LoginUser(
      repository: repository,
      validator: AuthCredentialValidator(),
    );

    await expectLater(
      useCase.execute(email: 'usuario@example.com', password: '1234567'),
      throwsArgumentError,
    );

    expect(repository.signedInEmail, isNull);
    expect(repository.signedInPassword, isNull);
  });
}
