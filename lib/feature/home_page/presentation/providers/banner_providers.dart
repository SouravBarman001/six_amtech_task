import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/banner_remote_datasource.dart';
import '../../data/repositories/banner_repository_impl.dart';
import '../../domain/entities/banner.dart';
import '../../domain/repositories/banner_repository.dart';
import '../../domain/usecases/banner_usecases.dart';
import '../state/banner_notifier.dart';
import '../state/banner_state.dart';

/// Provider for BannerRemoteDataSource
final bannerRemoteDataSourceProvider = Provider<BannerRemoteDataSource>(
  (ref) {
    final apiService = ref.read(stackFoodApiServiceProvider);
    return BannerRemoteDataSourceImpl(apiService);
  },
);

/// Provider for BannerRepository
final bannerRepositoryProvider = Provider<BannerRepository>(
  (ref) {
    final remoteDataSource = ref.read(bannerRemoteDataSourceProvider);
    return BannerRepositoryImpl(remoteDataSource);
  },
);

/// Provider for GetBannersUseCase
final getBannersUseCaseProvider = Provider<GetBannersUseCase>(
  (ref) {
    final repository = ref.read(bannerRepositoryProvider);
    return GetBannersUseCase(repository);
  },
);

/// Provider for RefreshBannersUseCase
final refreshBannersUseCaseProvider = Provider<RefreshBannersUseCase>(
  (ref) {
    final repository = ref.read(bannerRepositoryProvider);
    return RefreshBannersUseCase(repository);
  },
);

/// Provider for BannerNotifier
final bannerNotifierProvider = StateNotifierProvider<BannerNotifier, BannerState>(
  (ref) {
    final getBannersUseCase = ref.read(getBannersUseCaseProvider);
    final refreshBannersUseCase = ref.read(refreshBannersUseCaseProvider);
    
    return BannerNotifier(
      getBannersUseCase,
      refreshBannersUseCase,
    );
  },
);

/// Convenience provider for accessing banner state
final bannerStateProvider = Provider<BannerState>(
  (ref) => ref.watch(bannerNotifierProvider),
);

/// Provider for checking if banners are loading
final isBannerLoadingProvider = Provider<bool>(
  (ref) => ref.watch(bannerNotifierProvider.select((state) => state.isLoading)),
);

/// Provider for checking if banners are refreshing
final isBannerRefreshingProvider = Provider<bool>(
  (ref) => ref.watch(bannerNotifierProvider.select((state) => state.isRefreshing)),
);

/// Provider for getting banner error message
final bannerErrorProvider = Provider<String?>(
  (ref) => ref.watch(bannerNotifierProvider.select((state) => state.errorMessage)),
);

/// Provider for getting banners list
final bannersListProvider = Provider<List<Banner>>(
  (ref) => ref.watch(bannerNotifierProvider.select((state) => state.banners)),
);

/// Provider for checking if banners have data
final hasBannerDataProvider = Provider<bool>(
  (ref) => ref.watch(bannerNotifierProvider.select((state) => state.hasData)),
);

/// Provider for checking if banners are empty
final isBannerEmptyProvider = Provider<bool>(
  (ref) => ref.watch(bannerNotifierProvider.select((state) => state.isEmpty)),
);
