abstract class AuthRepository {
  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String phone,
    required String password,
  });

  Future<void> login({
    required String email,
    required String password,
  });
}
