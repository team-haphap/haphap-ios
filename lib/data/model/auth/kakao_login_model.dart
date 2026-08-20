class KakaoLoginModel {
  const KakaoLoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.name,
    required this.anonymousName,
  });

  final String accessToken;
  final String refreshToken;
  final String name;
  final String anonymousName;
}
