import '../../../../core/util/result.dart';
import '../../../../core/util/run_catching.dart';
import '../../../local/datasource/api/local_token_data_source.dart';
import '../../../mapper/auth/auth_mapper.dart';
import '../../../model/auth/kakao_login_model.dart';
import '../../../remote/datasource/api/auth/auth_data_source.dart';
import '../../../remote/dto/auth/kakao_login_request_dto.dart';
import '../../api/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authDataSource, this._localTokenDataSource);

  final AuthDataSource _authDataSource;
  final LocalTokenDataSource _localTokenDataSource;

  @override
  Future<Result<KakaoLoginModel>> postKakaoLogin(String accessToken) {
    return runCatchingAsync(() async {
      final response = await _authDataSource.postKakaoLogin(
        KakaoLoginRequestDto(accessToken),
      );
      final dto = response.checkData();

      await _localTokenDataSource.setAccessToken(dto.accessToken);
      await _localTokenDataSource.setRefreshToken(dto.refreshToken);

      return dto.toModel();
    });
  }

  @override
  Future<Result<KakaoLoginModel>> reissue() {
    return runCatchingAsync(() async {
      final refreshToken = await _localTokenDataSource.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        throw StateError('저장된 refresh token이 없습니다.');
      }

      final response = await _authDataSource.reissue(refreshToken);
      final dto = response.checkData();

      await _localTokenDataSource.setAccessToken(dto.accessToken);
      await _localTokenDataSource.setRefreshToken(dto.refreshToken);

      return dto.toModel();
    });
  }

  @override
  Future<Result<void>> logout() {
    return runCatchingAsync(() async {
      await _authDataSource.logout();
      await _localTokenDataSource.clearTokens();
    });
  }
}
