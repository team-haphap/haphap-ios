/// Android `CalendarPostingsResponseDto.kt`에 대응.
/// `GET /api/v1/calendar/postings` 응답.
class CalendarPostingsResponseDto {
  const CalendarPostingsResponseDto({required this.date, required this.postings});

  factory CalendarPostingsResponseDto.fromJson(Map<String, dynamic> json) {
    return CalendarPostingsResponseDto(
      date: json['date'] as String,
      postings: (json['postings'] as List)
          .map((e) => CalendarPostingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String date;
  final List<CalendarPostingDto> postings;
}

class CalendarPostingDto {
  const CalendarPostingDto({
    required this.postingId,
    required this.title,
    required this.stageName,
    required this.likelihood,
    required this.participantCount,
    required this.logoImageUrl,
  });

  factory CalendarPostingDto.fromJson(Map<String, dynamic> json) {
    return CalendarPostingDto(
      postingId: json['postingId'] as int,
      title: json['title'] as String,
      stageName: json['stageName'] as String,
      likelihood: json['likelihood'] as String,
      participantCount: json['participantCount'] as int,
      logoImageUrl: json['logoImageUrl'] as String,
    );
  }

  final int postingId;
  final String title;
  final String stageName;
  final String likelihood;
  final int participantCount;
  final String logoImageUrl;
}
