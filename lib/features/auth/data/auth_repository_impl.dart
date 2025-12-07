import 'package:dio/dio.dart';
import 'package:pets_shelter_system/core/constants.dart';
import 'package:pets_shelter_system/core/api_client.dart';
import 'package:pets_shelter_system/core/token_storage.dart';
import 'package:pets_shelter_system/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
    };

    try {
      final response =
      await _dio.post(ApiConstants.registerEndpoint, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }

      throw Exception(_extractErrorMessage(response));
    } on DioException catch (e) {
      final msg = _extractDioError(e);
      throw Exception(msg);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final body = {
      "email": email,
      "password": password,
    };

    try {
      final response =
      await _dio.post(ApiConstants.loginEndpoint, data: body);

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;

          final token = data['token']?.toString();

          if (token != null && token.isNotEmpty) {
            await TokenStorage.saveToken(token);
            return token;
          }
        }
        throw Exception('Unexpected login response');
      }

      throw Exception(_extractErrorMessage(response));
    } on DioException catch (e) {
      final msg = _extractDioError(e);
      throw Exception(msg);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }



  String _extractErrorMessage(Response response) {
    try {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        return (data['message'] ??
            data['error'] ??
            data['title'] ??
            'Unknown error')
            .toString();
      }
      return 'Request failed with status: ${response.statusCode}';
    } catch (_) {
      return 'Request failed with status: ${response.statusCode}';
    }
  }

  String _extractDioError(DioException e) {
    if (e.response != null && e.response!.data is Map<String, dynamic>) {
      final data = e.response!.data as Map<String, dynamic>;
      return (data['message'] ??
          data['error'] ??
          data['title'] ??
          e.message ??
          'Request failed')
          .toString();
    }
    return e.message ?? 'Network error';
  }
}
