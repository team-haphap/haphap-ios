import '../../entity/home/today_expected_job_entity.dart';
import '../../repository/home/home_repository.dart';

class GetTodayExpectedJobsUseCase {
  const GetTodayExpectedJobsUseCase(this._repository);

  final HomeRepository _repository;

  Future<List<TodayExpectedJobEntity>> execute() {
    return _repository.getTodayExpectedJobs();
  }
}
