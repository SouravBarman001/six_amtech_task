import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'network.dart';

/// Provider for StackFood API Service
final stackFoodApiServiceProvider = Provider<StackFoodApiService>(
  (ref) {
    final restClient = ref.read(networkProvider);
    return StackFoodApiService(restClient);
  },
);
