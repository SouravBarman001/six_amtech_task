import '../../../../core/utils/result.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

/// Use case for getting current location
class GetCurrentLocationUseCase {
  final LocationRepository _repository;

  const GetCurrentLocationUseCase(this._repository);

  /// Execute the use case to get current location
  Future<Result<Location>> call() async {
    return await _repository.getCurrentLocation();
  }
}
