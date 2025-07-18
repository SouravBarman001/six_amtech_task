import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import '../../data/datasources/campaign_remote_data_source.dart';
import '../../data/repositories/campaign_repository_impl.dart';
import '../../domain/repositories/campaign_repository.dart';
import '../../domain/usecases/get_campaigns_usecase.dart';
import '../state/campaign_notifier.dart';
import '../state/campaign_state.dart';

/// Provider for CampaignRemoteDataSource
final campaignRemoteDataSourceProvider = Provider<CampaignRemoteDataSource>((ref) {
  final apiService = ref.read(stackFoodApiServiceProvider);
  return CampaignRemoteDataSource(apiService);
});

/// Provider for CampaignRepository
final campaignRepositoryProvider = Provider<CampaignRepository>((ref) {
  final remoteDataSource = ref.read(campaignRemoteDataSourceProvider);
  return CampaignRepositoryImpl(remoteDataSource);
});

/// Provider for GetCampaignsUseCase
final getCampaignsUseCaseProvider = Provider<GetCampaignsUseCase>((ref) {
  final repository = ref.read(campaignRepositoryProvider);
  return GetCampaignsUseCase(repository);
});

/// Provider for CampaignNotifier
final campaignNotifierProvider = StateNotifierProvider<CampaignNotifier, CampaignState>((ref) {
  final useCase = ref.read(getCampaignsUseCaseProvider);
  return CampaignNotifier(useCase);
});

// Convenience providers for accessing specific state parts
final campaignStateProvider = Provider<CampaignState>((ref) {
  return ref.watch(campaignNotifierProvider);
});

final isCampaignLoadingProvider = Provider<bool>((ref) {
  return ref.watch(campaignNotifierProvider).isLoading;
});

final campaignsListProvider = Provider((ref) {
  return ref.watch(campaignNotifierProvider).campaigns;
});

final campaignErrorProvider = Provider<String?>((ref) {
  return ref.watch(campaignNotifierProvider).error;
});
