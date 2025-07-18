import '../../../../core/utils/result.dart';
import '../repositories/location_repository.dart';

/// Use case for getting formatted address from coordinates
class GetAddressFromCoordinatesUseCase {
  final LocationRepository _repository;

  const GetAddressFromCoordinatesUseCase(this._repository);

  /// Execute the use case to get address from coordinates
  Future<Result<String>> call(double latitude, double longitude) async {
    return await _repository.getAddressFromCoordinates(latitude, longitude);
  }
}
