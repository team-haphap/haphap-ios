class KakaoLoginResponseDto {
  const KakaoLoginResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.name,
    required this.anonymousName,
  });

  factory KakaoLoginResponseDto.fromJson(Map<String, dynamic> json) {
    return KakaoLoginResponseDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      name: json['name'] as String,
      anonymousName: json['anonymousName'] as String,
    );
  }

  final String accessToken;
  final String refreshToken;
  final String name;
  final String anonymousName;
}
