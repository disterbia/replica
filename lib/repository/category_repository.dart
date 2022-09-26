import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/category.dart';
import 'package:panda/provider/category_provider.dart';

class CategoryRepository{

  final CategoryProvider _categoryProvider = CategoryProvider();

  Future<List<Category>> findAll() async {
    QuerySnapshot querySnapshot = await _categoryProvider.findAll();
    List<Category> categorys = querySnapshot.docs
        .map((e) => Category.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return categorys;
  }

}