import '../../../../core/util/result.dart';
import '../../../model/auth/kakao_login_model.dart';

abstract class AuthRepository {
  Future<Result<KakaoLoginModel>> postKakaoLogin(String accessToken);

  /// haphap-android 앱은 아직 안 붙였지만 백엔드엔 있는 엔드포인트.
  Future<Result<KakaoLoginModel>> reissue();

  Future<Result<void>> logout();
}
