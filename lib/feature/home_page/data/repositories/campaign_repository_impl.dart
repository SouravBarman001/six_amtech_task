import '../../../../core/utils/result.dart';
import '../../domain/entities/campaign.dart';
import '../../domain/repositories/campaign_repository.dart';
import '../datasources/campaign_remote_data_source.dart';

/// Implementation of CampaignRepository
class CampaignRepositoryImpl implements CampaignRepository {
  final CampaignRemoteDataSource _remoteDataSource;

  const CampaignRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<Campaign>>> getCampaigns() async {
    try {
      final campaignModels = await _remoteDataSource.getCampaigns();
      final campaigns = campaignModels.map((model) => model.toEntity()).toList();
      
      return Success(campaigns);
    } catch (e) {
      return Failed('Failed to get campaigns: ${e.toString()}');
    }
  }
}
