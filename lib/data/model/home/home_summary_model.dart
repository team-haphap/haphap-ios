import '../../../domain/entity/home/home_summary_entity.dart';

class HomeSummaryModel {
  const HomeSummaryModel({
    required this.sharedResultCount,
    required this.ongoingJobCount,
    required this.announcedTodayCount,
  });

  factory HomeSummaryModel.fromJson(Map<String, dynamic> json) {
    return HomeSummaryModel(
      sharedResultCount: json['sharedResultCount'] as int,
      ongoingJobCount: json['ongoingJobCount'] as int,
      announcedTodayCount: json['announcedTodayCount'] as int,
    );
  }

  final int sharedResultCount;
  final int ongoingJobCount;
  final int announcedTodayCount;

  HomeSummaryEntity toEntity() {
    return HomeSummaryEntity(
      sharedResultCount: sharedResultCount,
      ongoingJobCount: ongoingJobCount,
      announcedTodayCount: announcedTodayCount,
    );
  }
}
