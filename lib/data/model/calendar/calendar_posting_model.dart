import '../../../core/type/present_chance_type.dart';

/// Android `CalendarPostingModel.kt`에 대응. 선택한 날짜의 공고 카드 하나.
class CalendarPostingModel {
  const CalendarPostingModel({
    required this.id,
    required this.title,
    required this.stageName,
    required this.likelihood,
    required this.participantCount,
    required this.logoImageUrl,
  });

  final int id;
  final String title;
  final String stageName;
  final PresentChanceType likelihood;
  final int participantCount;
  final String logoImageUrl;
}
