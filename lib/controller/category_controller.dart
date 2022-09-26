import 'package:get/get.dart';
import 'package:panda/model/category.dart';
import 'package:panda/repository/category_repository.dart';

class CategoryContrlloer extends GetxController with StateMixin{
  final CategoryRepository _categoryRepository= CategoryRepository();
  List<Category> categorys = <Category>[];
  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  Future<void> findAll() async{
    change(null,status: RxStatus.loading());
    List<Category> categorys = await _categoryRepository.findAll();
    this.categorys=categorys;
    change(null, status: RxStatus.success());
  }


}