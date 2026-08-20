/// Android `RegisterRequestDto.kt`에 대응.
class RegisterRequestDto {
  const RegisterRequestDto({
    required this.postingId,
    required this.stageId,
    this.contactedDate,
    this.contactedTime,
    this.contactMethods,
    required this.result,
    required this.anonymous,
    required this.alarmEnabled,
  });

  final int postingId;
  final int stageId;
  final String? contactedDate;
  final String? contactedTime;
  final List<String>? contactMethods;
  final String result;
  final bool anonymous;
  final bool alarmEnabled;

  Map<String, dynamic> toJson() {
    return {
      'postingId': postingId,
      'stageId': stageId,
      'contactedDate': contactedDate,
      'contactedTime': contactedTime,
      'contactMethods': contactMethods,
      'result': result,
      'anonymous': anonymous,
      'alarmEnabled': alarmEnabled,
    };
  }
}
