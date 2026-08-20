/// Android `RegisterStageListResponseDto.kt`에 대응.
class RegisterStageListResponseDto {
  const RegisterStageListResponseDto({
    required this.postingId,
    required this.stages,
  });

  factory RegisterStageListResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterStageListResponseDto(
      postingId: json['postingId'] as int,
      stages: (json['stages'] as List)
          .map((e) => RegisterStageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int postingId;
  final List<RegisterStageDto> stages;
}

class RegisterStageDto {
  const RegisterStageDto({
    required this.stageId,
    required this.stageName,
    this.orderIndex,
  });

  factory RegisterStageDto.fromJson(Map<String, dynamic> json) {
    return RegisterStageDto(
      stageId: json['stageId'] as int,
      stageName: json['stageName'] as String,
      orderIndex: json['orderIndex'] as int?,
    );
  }

  final int stageId;
  final String stageName;

  /// 응답엔 있지만 매퍼에서 쓰지 않는 필드 (Android와 동일).
  final int? orderIndex;
}
