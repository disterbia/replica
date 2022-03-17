import 'package:get/get.dart';
import 'package:panda/repository/product_repository.dart';

import '../model/product.dart';

class ProductController extends GetxController{
  final ProductRepository _productRepository = ProductRepository();
  final products = <Product>[].obs;
  final product = Product().obs;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  Future<void> findAll() async{
    List<Product> products = await _productRepository.findAll();
    this.products.value=products;
  }

  Future<void> findById(String id) async {
    Product product = await _productRepository.findById(id);
    this.product.value=product;
  }

  Future<void> findByCategory(String category) async {
    List<Product> products = await _productRepository.findByCategory(category);
    this.products.value=products;
  }



  Future<void> save(Product newProduct) async{
    Product product = await _productRepository.save(newProduct);
    this.products.add(product);
  }
}