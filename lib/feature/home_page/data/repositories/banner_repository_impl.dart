import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/banner.dart';
import '../../domain/repositories/banner_repository.dart';
import '../datasources/banner_remote_datasource.dart';

/// Implementation of BannerRepository
class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource _remoteDataSource;

  BannerRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<Banner>>> getBanners() async {
    try {
      final bannerModels = await _remoteDataSource.getBanners();
      final banners = bannerModels.map((model) => model.toEntity()).toList();
      
      return Success(banners);
    } on Failure catch (failure) {
      return Failed(_getErrorMessage(failure));
    } catch (e) {
      return Failed('Unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<Banner>>> refreshBanners() async {
    // For now, this is the same as getBanners since we don't have caching
    // In a real app, you might clear cache here and fetch fresh data
    return await getBanners();
  }

  /// Helper method to get user-friendly error messages
  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case BadRequest:
        return 'Invalid request. Please try again.';
      case Unauthorized:
        return 'You are not authorized to access this content.';
      case Forbidden:
        return 'Access to this content is forbidden.';
      case NotFound:
        return 'Content not found.';
      case InternalServerError:
        return 'Server error. Please try again later.';
      case RequestTimeout:
        return 'Request timed out. Please check your connection.';
      case ServiceUnavailable:
        return 'Service is currently unavailable. Please try again later.';
      default:
        return 'Failed to load banners: ${failure.name ?? 'Unknown error'}';
    }
  }
}
