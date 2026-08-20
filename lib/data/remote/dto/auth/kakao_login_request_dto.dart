class KakaoLoginRequestDto {
  const KakaoLoginRequestDto(this.accessToken);

  final String accessToken;

  Map<String, dynamic> toJson() => {'accessToken': accessToken};
}
