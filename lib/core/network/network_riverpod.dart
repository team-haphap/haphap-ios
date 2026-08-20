import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/local/datasource/api/local_token_data_source.dart';
import '../../data/local/datasource/impl/local_token_data_source_impl.dart';
import 'auth_interceptor.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

final localTokenDataSourceProvider = Provider<LocalTokenDataSource>(
  (ref) => LocalTokenDataSourceImpl(ref.read(secureStorageProvider)),
);

/// Base URL comes from `API_BASE_URL` in `.env` — never hardcoded here, so
/// switching between local/staging/prod only touches `.env`.
final dioProvider = Provider<Dio>((ref) {
  final baseUrl = dotenv.env['API_BASE_URL'];
  if (baseUrl == null || baseUrl.isEmpty) {
    throw StateError('.env에 API_BASE_URL이 설정되어 있지 않아요.');
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );
  dio.interceptors.add(AuthInterceptor(ref.read(localTokenDataSourceProvider)));

  // Android의 HttpLoggingInterceptor(BODY 레벨, 디버그 전용)에 대응.
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  return dio;
});
