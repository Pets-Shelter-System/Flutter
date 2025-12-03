import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_shelter_system/features/auth/domain/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    try {
      await authRepository.register(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      emit(AuthRegisterSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final token = await authRepository.login(
        email: email,
        password: password,
      );
      emit(AuthLoginSuccess(token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void reset() {
    emit(AuthInitial());
  }
}
