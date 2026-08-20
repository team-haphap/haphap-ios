import '../../model/auth/kakao_login_model.dart';
import '../../remote/dto/auth/kakao_login_response_dto.dart';

extension KakaoLoginResponseDtoMapper on KakaoLoginResponseDto {
  KakaoLoginModel toModel() {
    return KakaoLoginModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      name: name,
      anonymousName: anonymousName,
    );
  }
}
