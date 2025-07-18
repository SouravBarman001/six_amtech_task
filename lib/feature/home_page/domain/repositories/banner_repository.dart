import '../../../../core/utils/result.dart';
import '../entities/banner.dart';

/// Abstract repository interface for banner operations
abstract class BannerRepository {
  /// Get all active banners
  Future<Result<List<Banner>>> getBanners();
  
  /// Refresh banners from remote source
  Future<Result<List<Banner>>> refreshBanners();
}
