import 'package:get/get.dart';
import 'package:panda/repository/product_repository.dart';

import '../model/product.dart';

class ProductController extends GetxController with StateMixin {
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
    change(null,status: RxStatus.loading());
    findByCategory("남성의류");
    findByCategory("여성의류");
    findByCategory("남성신발");
    findByCategory("여성신발");
    findByCategory("운동화");
    findByCategory("가방/지갑/악세사리");
    change(null, status: RxStatus.success());
  }

  Future<void> findById(String id) async {
    change(null,status: RxStatus.loading());

    Product product = await _productRepository.findById(id);
    this.product.value = product;

    change(null, status: RxStatus.success());
  }

  Future<void> findByCategory(String category) async {
    List<Product> products = await _productRepository.findByCategory(category);
    switch (category) {
      case "남성의류":
        manCloth.value = products;
        break;
      case "여성의류":
        girlCloth.value = products;
        break;
      case "남성신발":
        manShose.value = products;
        break;
      case "여성신발":
        girlShose.value = products;
        break;
      case "운동화":
        sneakers.value = products;
        break;
      case "가방/지갑/악세사리":
        etc.value = products;
        break;
    }
  }

  void changeCategory(String category) {
    switch (category) {
      case "남성의류":
        products.value = manCloth;
        break;
      case "여성의류":
        products.value = girlCloth;
        break;
      case "남성신발":
        products.value = manShose;
        break;
      case "여성신발":
        products.value = girlShose;
        break;
      case "운동화":
        products.value = sneakers;
        break;
      case "가방/지갑/악세사리":
        products.value = etc;
        break;
    }
  }

  Future<void> save(Product newProduct,String category) async {
    change(null,status: RxStatus.loading());
    Product product = await _productRepository.save(newProduct);
    findByCategory(category);
    //products.insert(0, product); //이러면 새로고침해야 제대로 보임

    change(null, status: RxStatus.success());
  }

  Future<void> delete(String id) async {
    change(null,status: RxStatus.loading());

    await _productRepository.delete(id);
    List<Product> result =
        products.where((product) => product.id != id).toList();
    products.value = result;

    change(null, status: RxStatus.success());
  }

  Future<void> updateProduct(Product newProduct) async {
    change(null,status: RxStatus.loading());

    await _productRepository.update(newProduct);
    Product product = await _productRepository.findById(newProduct.id!);
    this.product.value = product;
    this.products.value =
        this.products.map((e) => e.id == newProduct.id ? product : e).toList();

    change(null, status: RxStatus.success());
  }

  void search(String txt,String category) {
    change(null,status: RxStatus.loading());

    changeCategory(category);
    List<Product> result =
      this.products.where((p)
      {
        return p.name!.contains(txt) || p.comment!.contains(txt);
      }).toList();
    this.products.value=result;

    change(null, status: RxStatus.success());
  }
}
