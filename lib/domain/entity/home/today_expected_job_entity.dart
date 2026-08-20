import 'job_category.dart';

/// "오늘 발표 예상 공고" 리스트 아이템.
class TodayExpectedJobEntity {
  const TodayExpectedJobEntity({
    required this.company,
    required this.title,
    required this.category,
    required this.expectedStage,
    required this.dDay,
  });

  final String company;
  final String title;
  final JobCategory category;

  /// ex. "서류" — "[전형] 발표 예상" 문구의 [전형] 부분
  final String expectedStage;
  final String dDay;
}
