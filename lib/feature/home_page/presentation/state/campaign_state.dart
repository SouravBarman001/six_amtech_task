import 'package:equatable/equatable.dart';
import '../../domain/entities/campaign.dart';

/// State for Campaign feature
class CampaignState extends Equatable {
  final List<Campaign> campaigns;
  final bool isLoading;
  final String? error;

  const CampaignState({
    this.campaigns = const [],
    this.isLoading = false,
    this.error,
  });

  /// Create a copy with modified fields
  CampaignState copyWith({
    List<Campaign>? campaigns,
    bool? isLoading,
    String? error,
  }) {
    return CampaignState(
      campaigns: campaigns ?? this.campaigns,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  /// Check if there's an error
  bool get hasError => error != null;

  /// Check if campaigns are empty
  bool get isEmpty => campaigns.isEmpty;

  @override
  List<Object?> get props => [campaigns, isLoading, error];
}
