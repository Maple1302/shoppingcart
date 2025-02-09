import 'package:shoppingcart/data/repository/product_repository.dart';

import '../data/models/product.dart';

class ProductService {
  final ProductRepository _productRepository;

  ProductService({ProductRepository? repo})
      : _productRepository = ProductRepository();
  static const waitingTime = Duration(seconds: 1);

  Future callApi() async {
    await Future.delayed(waitingTime);
  }

  Future<List<Product>> getProducts({
    int page = 1,
    int pageSize = 10,
  }) async {
    return await callApi().then(
      (_) async {
        // List<Product> productHotList = List.generate(
        //   10,
        //   (index) => Product(
        //       id: page * pageSize + index + 5,
        //       // Đảm bảo ID không bị trùng
        //       name: 'Product # $index ',
        //       image: 'assets/images/product_$index.jpg',
        //       price: page * 10000 + index.toDouble() * 10000,
        //       isHot: true),
        // );
        // for (int i = 0; i < productHotList.length; i++) {
        //   await _productRepository.insertProduct(productHotList[i]);
        // }
        List<Product> productList = await _productRepository.getListProduct();
        return List.generate(
          pageSize,
          (index) {
            return productList[index];
          },
        );
      },
    );
  }

  Future<List<Product>> getHotProducts() async {
    return await callApi().then(
      (_) async {
        return await _productRepository.getProductHot();
      },
    );
  }
}
