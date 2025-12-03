abstract class AuthRepository {
  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  });


  Future<String> login({
    required String email,
    required String password,
  });
}
