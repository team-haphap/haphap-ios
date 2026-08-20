import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/local_token_data_source.dart';

/// Android판은 (암호화되지 않은) DataStore Preferences를 쓰지만, 여기선
/// 더 안전한 [FlutterSecureStorage](암호화 저장소)를 쓴다 — 동작은 동일,
/// 저장 방식만 더 안전하게 바꾼 의도적인 차이.
class LocalTokenDataSourceImpl implements LocalTokenDataSource {
  const LocalTokenDataSourceImpl(this._storage);

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  @override
  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);

  @override
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  @override
  Future<void> setAccessToken(String accessToken) {
    return _storage.write(key: _accessTokenKey, value: accessToken);
  }

  @override
  Future<void> setRefreshToken(String refreshToken) {
    return _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
