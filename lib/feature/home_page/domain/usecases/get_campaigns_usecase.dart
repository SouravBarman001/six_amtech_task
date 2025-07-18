import '../../../../core/utils/result.dart';
import '../entities/campaign.dart';
import '../repositories/campaign_repository.dart';

/// Use case for getting food campaigns
class GetCampaignsUseCase {
  final CampaignRepository _repository;

  const GetCampaignsUseCase(this._repository);

  /// Execute the use case to get food campaigns
  /// Returns: Result containing list of campaigns or error
  Future<Result<List<Campaign>>> call() async {
    return await _repository.getCampaigns();
  }
}
