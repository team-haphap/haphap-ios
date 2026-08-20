import 'package:dio/dio.dart';

import '../dto/auth/kakao_login_request_dto.dart';
import '../dto/auth/kakao_login_response_dto.dart';
import '../dto/base_response.dart';

/// Android `AuthService.kt`(Retrofit)에 대응하는 얇은 Dio 래퍼.
///
/// `/api/v1/auth/reissue`, `/api/v1/auth/logout`은 haphap-android 앱이
/// 아직 붙이지 않았지만 백엔드엔 이미 있어서(같은 `BaseResponse` 규약을
/// 쓴다고 가정) 여기 남겨둔다 — 나중에 토큰 재발급/로그아웃 붙일 때 바로
/// 쓸 수 있게.
class AuthService {
  const AuthService(this._dio);

  final Dio _dio;

  Future<BaseResponse<KakaoLoginResponseDto>> kakaoLogin(
    KakaoLoginRequestDto request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/auth/kakao',
      data: request.toJson(),
    );
    return BaseResponse.fromJson(
      response.data!,
      KakaoLoginResponseDto.fromJson,
    );
  }

  Future<BaseResponse<KakaoLoginResponseDto>> reissue(
    String refreshToken,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/auth/reissue',
      options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
    );
    return BaseResponse.fromJson(
      response.data!,
      KakaoLoginResponseDto.fromJson,
    );
  }

  /// 204 No Content — 예외 없이 끝나면 성공.
  Future<void> logout() async {
    await _dio.post<void>('/api/v1/auth/logout');
  }
}
