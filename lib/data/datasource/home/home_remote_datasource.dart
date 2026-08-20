import '../../../domain/entity/home/job_category.dart';
import '../../model/home/home_banner_model.dart';
import '../../model/home/home_summary_model.dart';
import '../../model/home/recent_result_job_model.dart';
import '../../model/home/today_expected_job_model.dart';

/// TODO: 백엔드 API 나오면 [HomeRemoteDataSourceImpl](Dio 기반)로 교체.
abstract class HomeRemoteDataSource {
  Future<HomeSummaryModel> getSummary();

  Future<List<HomeBannerModel>> getBanners();

  Future<List<RecentResultJobModel>> getRecentResultJobs({
    Set<JobCategory> categories = const {},
  });

  Future<List<TodayExpectedJobModel>> getTodayExpectedJobs();
}

/// API 연동 전까지 사용하는 목업 데이터소스.
class HomeMockRemoteDataSource implements HomeRemoteDataSource {
  const HomeMockRemoteDataSource();

  static const _summary = HomeSummaryModel(
    sharedResultCount: 37,
    ongoingJobCount: 37,
    announcedTodayCount: 37,
  );

  static const _banners = [
    HomeBannerModel(
      title: '지원 이후, 보이지 않던\n기다림을 더욱 선명하게',
      subtitle: '같은 공고 지원자들의 결과를 확인해보세요!',
    ),
    HomeBannerModel(
      title: '결과 발표, 이제\n혼자 기다리지 마세요',
      subtitle: '실시간으로 공유되는 합격 소식을 만나보세요',
    ),
    HomeBannerModel(
      title: '내 지원 현황을\n한눈에 관리해보세요',
      subtitle: '캘린더로 발표 일정을 놓치지 마세요',
    ),
  ];

  static const _recentResultJobs = [
    RecentResultJobModel(
      company: '카카오',
      title: '2026 신입 공개채용 백엔드 개발자',
      category: JobCategory.devData,
      stageLabel: '서류 발표',
      dDay: 'D-2',
    ),
    RecentResultJobModel(
      company: '네이버',
      title: '2026 상반기 신입 공채',
      category: JobCategory.devData,
      stageLabel: '1차 면접 발표',
      dDay: 'D-1',
    ),
    RecentResultJobModel(
      company: '토스',
      title: 'Product Designer 채용',
      category: JobCategory.design,
      stageLabel: '서류 발표',
      dDay: 'D-3',
    ),
    RecentResultJobModel(
      company: '당근',
      title: '인사 담당자 채용',
      category: JobCategory.hr,
      stageLabel: '최종 발표',
      dDay: 'D-0',
    ),
  ];

  static const _todayExpectedJobs = [
    TodayExpectedJobModel(
      company: '카카오',
      title: '2026 신입 공개채용',
      category: JobCategory.devData,
      expectedStage: '서류',
      dDay: 'D-2',
    ),
    TodayExpectedJobModel(
      company: '라인',
      title: '프론트엔드 개발자 채용',
      category: JobCategory.devData,
      expectedStage: '1차 면접',
      dDay: 'D-1',
    ),
    TodayExpectedJobModel(
      company: '쿠팡',
      title: '영업 관리 직무 채용',
      category: JobCategory.sales,
      expectedStage: '최종',
      dDay: 'D-0',
    ),
  ];

  @override
  Future<HomeSummaryModel> getSummary() async => _summary;

  @override
  Future<List<HomeBannerModel>> getBanners() async => _banners;

  @override
  Future<List<RecentResultJobModel>> getRecentResultJobs({
    Set<JobCategory> categories = const {},
  }) async {
    if (categories.isEmpty) return _recentResultJobs;
    return _recentResultJobs
        .where((job) => categories.contains(job.category))
        .toList();
  }

  @override
  Future<List<TodayExpectedJobModel>> getTodayExpectedJobs() async =>
      _todayExpectedJobs;
}
