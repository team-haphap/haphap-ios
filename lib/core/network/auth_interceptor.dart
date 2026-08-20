import 'package:dio/dio.dart';

import '../../data/local/datasource/api/local_token_data_source.dart';

/// Android `TokenInterceptor.kt`에 대응 — 저장된 액세스 토큰을 모든 요청에
/// 자동으로 붙인다.
///
/// `/api/v1/auth/reissue`처럼 리프레시 토큰이 필요한 엔드포인트는 자기
/// 요청에 직접 `Authorization` 헤더를 지정해서 이 기본 동작을 덮어쓴다.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._localTokenDataSource);

  final LocalTokenDataSource _localTokenDataSource;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.headers.containsKey('Authorization')) {
      final accessToken = await _localTokenDataSource.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    handler.next(options);
  }
}
