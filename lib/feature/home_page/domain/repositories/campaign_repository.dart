import '../../../../core/utils/result.dart';
import '../entities/campaign.dart';

/// Repository interface for Campaign operations
abstract class CampaignRepository {
  /// Get list of food campaigns
  /// Returns: Result containing list of campaigns or error
  Future<Result<List<Campaign>>> getCampaigns();
}
