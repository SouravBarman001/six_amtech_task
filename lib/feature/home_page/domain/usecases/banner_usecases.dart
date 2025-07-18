import '../../../../core/utils/result.dart';
import '../entities/banner.dart';
import '../repositories/banner_repository.dart';

/// Use case for getting banners
class GetBannersUseCase {
  final BannerRepository _repository;

  const GetBannersUseCase(this._repository);

  /// Execute the use case to get banners
  Future<Result<List<Banner>>> call() async {
    return await _repository.getBanners();
  }
}

/// Use case for refreshing banners
class RefreshBannersUseCase {
  final BannerRepository _repository;

  const RefreshBannersUseCase(this._repository);

  /// Execute the use case to refresh banners
  Future<Result<List<Banner>>> call() async {
    return await _repository.refreshBanners();
  }
}
