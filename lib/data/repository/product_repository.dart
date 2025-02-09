import 'package:shoppingcart/data/local/product_dao.dart';
import '../models/product.dart';

class ProductRepository  {
  final ProductDao _productDao = ProductDao();

  Future<void> insertProduct(Product item) => _productDao.insertProduct(item);
  Future<List<Product>> getListProduct() => _productDao.getListProduct();
  Future<List<Product>> getProductHot() => _productDao.getProductHot();

}