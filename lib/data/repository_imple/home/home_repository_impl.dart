import '../../../domain/entity/home/home_banner_entity.dart';
import '../../../domain/entity/home/home_summary_entity.dart';
import '../../../domain/entity/home/job_category.dart';
import '../../../domain/entity/home/recent_result_job_entity.dart';
import '../../../domain/entity/home/today_expected_job_entity.dart';
import '../../../domain/repository/home/home_repository.dart';
import '../../datasource/home/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._dataSource);

  final HomeRemoteDataSource _dataSource;

  @override
  Future<HomeSummaryEntity> getSummary() async {
    final model = await _dataSource.getSummary();
    return model.toEntity();
  }

  @override
  Future<List<HomeBannerEntity>> getBanners() async {
    final models = await _dataSource.getBanners();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<RecentResultJobEntity>> getRecentResultJobs({
    Set<JobCategory> categories = const {},
  }) async {
    final models = await _dataSource.getRecentResultJobs(
      categories: categories,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<TodayExpectedJobEntity>> getTodayExpectedJobs() async {
    final models = await _dataSource.getTodayExpectedJobs();
    return models.map((m) => m.toEntity()).toList();
  }
}
