import '../../entity/home/home_summary_entity.dart';
import '../../repository/home/home_repository.dart';

class GetHomeSummaryUseCase {
  const GetHomeSummaryUseCase(this._repository);

  final HomeRepository _repository;

  Future<HomeSummaryEntity> execute() => _repository.getSummary();
}
