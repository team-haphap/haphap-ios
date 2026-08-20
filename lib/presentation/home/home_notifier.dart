import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/home/home_banner_entity.dart';
import '../../domain/entity/home/home_summary_entity.dart';
import '../../domain/entity/home/job_category.dart';
import '../../domain/entity/home/recent_result_job_entity.dart';
import '../../domain/entity/home/today_expected_job_entity.dart';
import 'home_riverpod.dart';

class HomeState {
  const HomeState({
    this.isLoading = true,
    this.summary,
    this.banners = const [],
    this.recentResultJobs = const [],
    this.todayExpectedJobs = const [],
    this.selectedCategories = const {},
  });

  final bool isLoading;
  final HomeSummaryEntity? summary;
  final List<HomeBannerEntity> banners;
  final List<RecentResultJobEntity> recentResultJobs;
  final List<TodayExpectedJobEntity> todayExpectedJobs;

  /// 비어있으면 "전체" 선택을 의미한다.
  final Set<JobCategory> selectedCategories;

  HomeState copyWith({
    bool? isLoading,
    HomeSummaryEntity? summary,
    List<HomeBannerEntity>? banners,
    List<RecentResultJobEntity>? recentResultJobs,
    List<TodayExpectedJobEntity>? todayExpectedJobs,
    Set<JobCategory>? selectedCategories,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      summary: summary ?? this.summary,
      banners: banners ?? this.banners,
      recentResultJobs: recentResultJobs ?? this.recentResultJobs,
      todayExpectedJobs: todayExpectedJobs ?? this.todayExpectedJobs,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }
}

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    _loadAll();
    return const HomeState();
  }

  Future<void> _loadAll() async {
    final results = await Future.wait([
      ref.read(getHomeSummaryUseCaseProvider).execute(),
      ref.read(getHomeBannersUseCaseProvider).execute(),
      ref
          .read(getRecentResultJobsUseCaseProvider)
          .execute(categories: state.selectedCategories),
      ref.read(getTodayExpectedJobsUseCaseProvider).execute(),
    ]);

    state = state.copyWith(
      isLoading: false,
      summary: results[0] as HomeSummaryEntity,
      banners: results[1] as List<HomeBannerEntity>,
      recentResultJobs: results[2] as List<RecentResultJobEntity>,
      todayExpectedJobs: results[3] as List<TodayExpectedJobEntity>,
    );
  }

  Future<void> refresh() => _loadAll();

  Future<void> setSelectedCategories(Set<JobCategory> categories) async {
    state = state.copyWith(selectedCategories: categories);
    final jobs = await ref
        .read(getRecentResultJobsUseCaseProvider)
        .execute(categories: categories);
    state = state.copyWith(recentResultJobs: jobs);
  }
}
