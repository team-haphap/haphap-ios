/// Android `RegistrationResponseDto.kt`에 대응.
class RegistrationResponseDto {
  const RegistrationResponseDto({required this.registrationId, this.card});

  factory RegistrationResponseDto.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseDto(
      registrationId: json['registrationId'] as int,
      card: json['card'] == null
          ? null
          : PassCardDto.fromJson(json['card'] as Map<String, dynamic>),
    );
  }

  final int registrationId;
  final PassCardDto? card;
}

class PassCardDto {
  const PassCardDto({
    required this.userName,
    required this.companyName,
    required this.companyCardLogoImageUrl,
    required this.title,
    required this.cardImageUrl,
  });

  factory PassCardDto.fromJson(Map<String, dynamic> json) {
    return PassCardDto(
      userName: json['userName'] as String,
      companyName: json['companyName'] as String,
      companyCardLogoImageUrl: json['companyCardLogoImageUrl'] as String,
      title: json['title'] as String,
      cardImageUrl: json['cardImageUrl'] as String,
    );
  }

  final String userName;
  final String companyName;
  final String companyCardLogoImageUrl;
  final String title;
  final String cardImageUrl;
}
