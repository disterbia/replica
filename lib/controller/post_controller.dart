import 'package:get/get.dart';
import 'package:panda/repository/product_repository.dart';

import '../model/product.dart';

class ProductController extends GetxController{
  final ProductRepository _productRepository = ProductRepository();
  final products = <Product>[].obs;
  final manCloth = <Product>[].obs;
  final girlCloth = <Product>[].obs;
  final manShose = <Product>[].obs;
  final girlShose = <Product>[].obs;
  final sneakers = <Product>[].obs;
  final etc = <Product>[].obs;
  final product = Product().obs;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    findAll();
    findByCategory("남성의류");
    findByCategory("여성의류");
    findByCategory("남성신발");
    findByCategory("여성신발");
    findByCategory("운동화");
    findByCategory("가방/지갑/악세사리");
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
    switch(category){
      case "남성의류" :
        manCloth.value=products;
        break;
      case "여성의류" :
        girlCloth.value=products;
        break;
      case "남성신발" :
        manShose.value=products;
        break;
      case "여성신발" :
        girlShose.value=products;
        break;
      case "운동화" :
        sneakers.value=products;
        break;
      case "가방/지갑/악세사리" :
        etc.value=products;
        break;
    }
  }
  void changeCategory(String category){
    switch(category){
      case "남성의류" :
        products.value=manCloth;
        break;
      case "여성의류" :
        products.value=girlCloth;
        break;
      case "남성신발" :
        products.value=manShose;
        break;
      case "여성신발" :
        products.value=girlShose;
        break;
      case "운동화" :
        products.value=sneakers;
        break;
      case "가방/지갑/악세사리" :
        products.value=etc;
        break;
    }
  }



  Future<void> save(Product newProduct) async{
    Product product = await _productRepository.save(newProduct);
    this.products.insert(0,product);

  }

  Future<void> delete(String id ) async {
    await _productRepository.delete(id);
    List<Product> result= products.where((product) => product.id != id).toList();
    products.value=result;
  }

  Future<void> updateProduct(Product newProduct) async {
    await _productRepository.update(newProduct);
    Product product = await _productRepository.findById(newProduct.id!);
    this.product.value=product;
    this.products.value=this.products.map((e) => e.id == newProduct.id ? product : e).toList();
  }
}