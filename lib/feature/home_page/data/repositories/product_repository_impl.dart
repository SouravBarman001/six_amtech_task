import '../../../../core/utils/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

/// Implementation of ProductRepository
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  const ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<Product>>> getPopularProducts() async {
    final result = await _remoteDataSource.getPopularProducts();

    switch (result) {
      case Success<List<ProductModel>>():
        // Convert models to entities
        final products = result.data.map((model) => model.toEntity()).toList();
        return Success(products);
      case Failed<List<ProductModel>>():
        return Failed(result.message, result.exception);
    }
  }
}
