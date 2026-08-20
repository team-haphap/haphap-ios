import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/home/home_remote_datasource.dart';
import '../../data/repository_imple/home/home_repository_impl.dart';
import '../../domain/usecase/home/get_home_banners_usecase.dart';
import '../../domain/usecase/home/get_home_summary_usecase.dart';
import '../../domain/usecase/home/get_recent_result_jobs_usecase.dart';
import '../../domain/usecase/home/get_today_expected_jobs_usecase.dart';
import 'home_notifier.dart';

// TODO: 실제 API 붙으면 HomeMockRemoteDataSource -> HomeRemoteDataSourceImpl로 교체.
final _homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>(
  (ref) => const HomeMockRemoteDataSource(),
);

final _homeRepositoryProvider = Provider(
  (ref) => HomeRepositoryImpl(ref.read(_homeRemoteDataSourceProvider)),
);

final getHomeSummaryUseCaseProvider = Provider(
  (ref) => GetHomeSummaryUseCase(ref.read(_homeRepositoryProvider)),
);

final getHomeBannersUseCaseProvider = Provider(
  (ref) => GetHomeBannersUseCase(ref.read(_homeRepositoryProvider)),
);

final getRecentResultJobsUseCaseProvider = Provider(
  (ref) => GetRecentResultJobsUseCase(ref.read(_homeRepositoryProvider)),
);

final getTodayExpectedJobsUseCaseProvider = Provider(
  (ref) => GetTodayExpectedJobsUseCase(ref.read(_homeRepositoryProvider)),
);

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
