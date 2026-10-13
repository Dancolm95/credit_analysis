import 'package:credit_analysis_app/domain/services/auth_credentials_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rechaza un correo sin arroba', () {
    final validator = AuthCredentialValidator();

    final result = validator.isEmailValid('usuarioexample.com');

    expect(result, isFalse);
  });

  test('rechaza un correo sin dominio', () {
    final validator = AuthCredentialValidator();

    final result = validator.isEmailValid('usuario@');

    expect(result, isFalse);
  });

  test('rechaza un correo sin nombre de usuario', () {
    final validator = AuthCredentialValidator();

    final result = validator.isEmailValid('@example.com');
    expect(result, isFalse);
  });

  test('rechaza un correo que no contenga un punto', () {
    final validator = AuthCredentialValidator();

    final result = validator.isEmailValid('usuario@examplecom');

    expect(result, isFalse);
  });

  test('rechaza un correo si el punto aparece antes del arroba', () {
    final validator = AuthCredentialValidator();
    final result = validator.isEmailValid('usuario.nombre@examplecom');
    expect(result, isFalse);
  });

  test('acepta un correio con nombre y dominio válido', () {
    final validator = AuthCredentialValidator();
    final result = validator.isEmailValid('usuario@example.com');

    expect(result, isTrue);
  });

  test('rechaza un correo con dos arrobas', () {
    final validator = AuthCredentialValidator();
    final result = validator.isEmailValid('usuario@@example.com');

    expect(result, isFalse);
  });

  test('rechaza un correo cuyo dominio comienza con punto', () {
    final validator = AuthCredentialValidator();
    final result = validator.isEmailValid('usuario@.com');

    expect(result, isFalse);
  });

  test('rechaza un correo cuyo dominio termina con punto', () {
    final validator = AuthCredentialValidator();
    final result = validator.isEmailValid('usuario@example.');

    expect(result, isFalse);
  });

  test('rechaza una contraseña con menos de 8 carácteres', () {
    final validator = AuthCredentialValidator();
    final result = validator.isPasswordValid('1234567');

    expect(result, isFalse);
  });

  test('acepta una contraseña con exactamente 8 carácteres', () {
    final validator = AuthCredentialValidator();
    final result = validator.isPasswordValid('12345678');

    expect(result, isTrue);
  });
}
