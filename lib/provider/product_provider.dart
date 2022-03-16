import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:panda/dto/update_dto.dart';

import '../model/product.dart';

class ProductProvider {
  final _collection = "product";

  Future<QuerySnapshot> findAll() => FirebaseFirestore.instance
      .collection(_collection)
      .orderBy("created", descending: true)
      .get();

  Future<DocumentSnapshot> findById(String id) =>
      FirebaseFirestore.instance.doc("$_collection/$id").get();

  Future<QuerySnapshot> findByCategory(String category) =>
      FirebaseFirestore.instance
          .collection(_collection)
          .where("category", isEqualTo: category)
          .orderBy("created", descending: true)
          .get();

  Future<DocumentSnapshot> save(Product product) => FirebaseFirestore.instance
      .collection(_collection)
      .add(product.toJson())
      //     .then((v) {
      // v.update({"id": v.id});
      // return v.get();
      // }
      .then((value) => value.get());

  Future<void> update(Product product) {
    String? id = product.id;
    return FirebaseFirestore.instance
        .doc("$_collection/$id")
        .update(UpdateDto(product: product).ProductToJson());
  }

  Future<void> delete(String id)=>
      FirebaseFirestore.instance.doc("$_collection/$id").delete();
}
