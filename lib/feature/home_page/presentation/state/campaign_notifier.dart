import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../../domain/usecases/get_campaigns_usecase.dart';
import 'campaign_state.dart';

/// Notifier for managing Campaign state
class CampaignNotifier extends StateNotifier<CampaignState> {
  final GetCampaignsUseCase _getCampaignsUseCase;

  CampaignNotifier(this._getCampaignsUseCase) : super(const CampaignState());

  /// Get campaigns from API
  Future<void> getCampaigns() async {
    if (state.isLoading) return;

    Log.info('CampaignNotifier: Starting to get campaigns');
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _getCampaignsUseCase();

      switch (result) {
        case Success():
          final data = result.data;
          Log.info('CampaignNotifier: Successfully got ${data.length} campaigns');
          state = state.copyWith(
            campaigns: data,
            isLoading: false,
            error: null,
          );
          break;
        case Failed():
          final message = result.message;
          Log.error('CampaignNotifier: Failed to get campaigns: $message');
          state = state.copyWith(
            isLoading: false,
            error: message,
          );
          break;
      }
    } catch (e) {
      Log.error('CampaignNotifier: Unexpected error getting campaigns: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Unexpected error: $e',
      );
    }
  }

  /// Retry getting campaigns
  Future<void> retry() async {
    Log.info('CampaignNotifier: Retrying to get campaigns');
    await getCampaigns();
  }

  /// Clear error state
  void clearError() {
    if (state.hasError) {
      state = state.copyWith(error: null);
    }
  }
}
