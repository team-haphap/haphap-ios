import '../../entity/home/home_banner_entity.dart';
import '../../entity/home/home_summary_entity.dart';
import '../../entity/home/job_category.dart';
import '../../entity/home/recent_result_job_entity.dart';
import '../../entity/home/today_expected_job_entity.dart';

abstract class HomeRepository {
  Future<HomeSummaryEntity> getSummary();

  Future<List<HomeBannerEntity>> getBanners();

  /// [categories]가 비어있으면 전체 카테고리를 의미한다.
  Future<List<RecentResultJobEntity>> getRecentResultJobs({
    Set<JobCategory> categories = const {},
  });

  Future<List<TodayExpectedJobEntity>> getTodayExpectedJobs();
}
