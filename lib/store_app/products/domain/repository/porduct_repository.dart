import 'package:store_app/store_app/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Stream<List<ProductEntity>> fetchAllProducts();
}
