/// Android `CalendarResponseDto.kt`에 대응. `GET /api/v1/calendar` 응답.
class CalendarResponseDto {
  const CalendarResponseDto({required this.dates});

  factory CalendarResponseDto.fromJson(Map<String, dynamic> json) {
    return CalendarResponseDto(
      dates: (json['dates'] as List)
          .map((e) => CalendarDateDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<CalendarDateDto> dates;
}

class CalendarDateDto {
  const CalendarDateDto({required this.date, required this.likelihood});

  factory CalendarDateDto.fromJson(Map<String, dynamic> json) {
    return CalendarDateDto(
      date: json['date'] as String,
      likelihood: json['likelihood'] as String,
    );
  }

  final String date;
  final String likelihood;
}
