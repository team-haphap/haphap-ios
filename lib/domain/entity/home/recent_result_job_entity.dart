import 'job_category.dart';

/// "최근 결과가 올라온 공고" 카드.
class RecentResultJobEntity {
  const RecentResultJobEntity({
    required this.company,
    required this.title,
    required this.category,
    required this.stageLabel,
    required this.dDay,
  });

  final String company;
  final String title;
  final JobCategory category;

  /// ex. "서류 발표", "1차 면접 발표"
  final String stageLabel;

  /// ex. "D-2"
  final String dDay;
}
