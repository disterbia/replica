import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/dto/update_dto.dart';
import '../model/product.dart';

class ProductProvider {
  final _collection = "product";
  final _store = FirebaseFirestore.instance;

  Future<DocumentSnapshot> findById(String id) =>
      _store.doc("$_collection/$id").get();

  Future<QuerySnapshot> findByCategory(String category) => _store
      .collection(_collection)
      .where("category", isEqualTo: category)
      .orderBy("created", descending: true)
      .get();

  Future<DocumentSnapshot> save(Product product) =>
      _store.collection(_collection).add(product.toJson()).then((v) async {
        await v.update({"id": v.id});
        return v.get();
      });

  Future<void> update(Product product) {
    String? id = product.id;
    return _store
        .doc("$_collection/$id")
        .update(UpdateDto(product: product).ProductToJson());
  }

  Future<void> delete(String id) => _store.doc("$_collection/$id").delete();
}
