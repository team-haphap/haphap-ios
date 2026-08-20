abstract class LocalTokenDataSource {
  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> setAccessToken(String accessToken);

  Future<void> setRefreshToken(String refreshToken);

  Future<void> clearTokens();
}
