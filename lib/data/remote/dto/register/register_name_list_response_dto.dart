/// Android `RegisterNameListResponseDto.kt`에 대응.
class RegisterNameListResponseDto {
  const RegisterNameListResponseDto({required this.postings});

  factory RegisterNameListResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterNameListResponseDto(
      postings: (json['postings'] as List)
          .map((e) => RegisterNameDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<RegisterNameDto> postings;
}

class RegisterNameDto {
  const RegisterNameDto({required this.id, required this.title});

  factory RegisterNameDto.fromJson(Map<String, dynamic> json) {
    return RegisterNameDto(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  final int id;
  final String title;
}
