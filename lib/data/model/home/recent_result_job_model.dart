import '../../../domain/entity/home/job_category.dart';
import '../../../domain/entity/home/recent_result_job_entity.dart';

class RecentResultJobModel {
  const RecentResultJobModel({
    required this.company,
    required this.title,
    required this.category,
    required this.stageLabel,
    required this.dDay,
  });

  factory RecentResultJobModel.fromJson(Map<String, dynamic> json) {
    return RecentResultJobModel(
      company: json['company'] as String,
      title: json['title'] as String,
      category: JobCategory.values.byName(json['category'] as String),
      stageLabel: json['stageLabel'] as String,
      dDay: json['dDay'] as String,
    );
  }

  final String company;
  final String title;
  final JobCategory category;
  final String stageLabel;
  final String dDay;

  RecentResultJobEntity toEntity() {
    return RecentResultJobEntity(
      company: company,
      title: title,
      category: category,
      stageLabel: stageLabel,
      dDay: dDay,
    );
  }
}
