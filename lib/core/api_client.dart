import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pets_shelter_system/core/constants.dart';
import 'package:pets_shelter_system/core/token_storage.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )
    ..httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();

        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          if (host == 'petmarket.runasp.net') {
            return true;
          }
          return false;
        };

        return client;
      },
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          debugPrint(
            '[API REQUEST] ${options.method} '
                '${options.baseUrl}${options.path}\n'
                'data: ${options.data}',
          );
          return handler.next(options);
        },
        onError: (e, handler) {
          debugPrint(
            '[API ERROR] ${e.requestOptions.method} '
                '${e.requestOptions.baseUrl}${e.requestOptions.path}\n'
                'type: ${e.type} message: ${e.message}',
          );
          return handler.next(e);
        },
      ),
    );
}
