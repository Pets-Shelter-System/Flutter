import 'package:pets_shelter_system/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // TODO: inject Dio or http client here later

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    // TODO: call your API here
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // TODO: call your API here
    await Future.delayed(const Duration(seconds: 1));
  }
}
