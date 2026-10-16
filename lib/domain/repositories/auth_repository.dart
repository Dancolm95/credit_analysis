abstract class AuthRepository {
  Future<void> register({required String email, required String password});
}
