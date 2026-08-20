import '../../../../remote/service/auth_service.dart';
import '../../../dto/auth/kakao_login_request_dto.dart';
import '../../../dto/auth/kakao_login_response_dto.dart';
import '../../../dto/base_response.dart';
import '../../api/auth/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl(this._authService);

  final AuthService _authService;

  @override
  Future<BaseResponse<KakaoLoginResponseDto>> postKakaoLogin(
    KakaoLoginRequestDto requestDto,
  ) {
    return _authService.kakaoLogin(requestDto);
  }

  @override
  Future<BaseResponse<KakaoLoginResponseDto>> reissue(String refreshToken) {
    return _authService.reissue(refreshToken);
  }

  @override
  Future<void> logout() {
    return _authService.logout();
  }
}
