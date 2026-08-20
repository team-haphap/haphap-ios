/// Android `RegistrationCheckRequestDto.kt`에 대응.
class RegistrationCheckRequestDto {
  const RegistrationCheckRequestDto({required this.result});

  final String result;

  Map<String, dynamic> toJson() => {'result': result};
}
