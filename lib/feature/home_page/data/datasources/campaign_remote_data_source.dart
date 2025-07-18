import 'package:dio/dio.dart';
import 'package:core/core.dart';
import '../models/campaign_model.dart';

/// Remote data source for Campaign operations
class CampaignRemoteDataSource {
  final StackFoodApiService _apiService;

  const CampaignRemoteDataSource(this._apiService);

  /// Get food campaigns from API
  /// Returns: List of CampaignModel
  /// Throws: Exception on API error
  Future<List<CampaignModel>> getCampaigns() async {
    try {
      Log.info('Fetching food campaigns from API');
      
      final response = await _apiService.getFoodCampaigns();
      
      Log.info('Food campaigns API response: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = response.data;
        
        if (data is List) {
          final campaigns = data
              .map((json) => CampaignModel.fromJson(json as Map<String, dynamic>))
              .toList();
          
          Log.info('Successfully parsed ${campaigns.length} campaigns');
          return campaigns;
        } else {
          Log.error('Invalid response format: expected List, got ${data.runtimeType}');
          throw Exception('Invalid response format');
        }
      } else {
        Log.error('API request failed with status: ${response.statusCode}');
        throw Exception('Failed to load campaigns: ${response.statusCode}');
      }
    } on DioException catch (e) {
      Log.error('Dio error while fetching campaigns: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      Log.error('Unexpected error while fetching campaigns: $e');
      throw Exception('Failed to load campaigns: $e');
    }
  }
}
