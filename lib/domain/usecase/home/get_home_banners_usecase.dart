import '../../entity/home/home_banner_entity.dart';
import '../../repository/home/home_repository.dart';

class GetHomeBannersUseCase {
  const GetHomeBannersUseCase(this._repository);

  final HomeRepository _repository;

  Future<List<HomeBannerEntity>> execute() => _repository.getBanners();
}
