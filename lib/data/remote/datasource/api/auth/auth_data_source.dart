import '../../../dto/auth/kakao_login_request_dto.dart';
import '../../../dto/auth/kakao_login_response_dto.dart';
import '../../../dto/base_response.dart';

abstract class AuthDataSource {
  Future<BaseResponse<KakaoLoginResponseDto>> postKakaoLogin(
    KakaoLoginRequestDto requestDto,
  );

  Future<BaseResponse<KakaoLoginResponseDto>> reissue(String refreshToken);

  Future<void> logout();
}
