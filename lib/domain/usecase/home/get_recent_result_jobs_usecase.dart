import '../../entity/home/job_category.dart';
import '../../entity/home/recent_result_job_entity.dart';
import '../../repository/home/home_repository.dart';

class GetRecentResultJobsUseCase {
  const GetRecentResultJobsUseCase(this._repository);

  final HomeRepository _repository;

  Future<List<RecentResultJobEntity>> execute({
    Set<JobCategory> categories = const {},
  }) {
    return _repository.getRecentResultJobs(categories: categories);
  }
}
