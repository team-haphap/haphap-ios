import '../../../domain/entity/home/job_category.dart';
import '../../../domain/entity/home/today_expected_job_entity.dart';

class TodayExpectedJobModel {
  const TodayExpectedJobModel({
    required this.company,
    required this.title,
    required this.category,
    required this.expectedStage,
    required this.dDay,
  });

  factory TodayExpectedJobModel.fromJson(Map<String, dynamic> json) {
    return TodayExpectedJobModel(
      company: json['company'] as String,
      title: json['title'] as String,
      category: JobCategory.values.byName(json['category'] as String),
      expectedStage: json['expectedStage'] as String,
      dDay: json['dDay'] as String,
    );
  }

  final String company;
  final String title;
  final JobCategory category;
  final String expectedStage;
  final String dDay;

  TodayExpectedJobEntity toEntity() {
    return TodayExpectedJobEntity(
      company: company,
      title: title,
      category: category,
      expectedStage: expectedStage,
      dDay: dDay,
    );
  }
}
