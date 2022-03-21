import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/order.dart';

class OrderProvider {
  final _collection = "order";
  final _store = FirebaseFirestore.instance;

  Future<QuerySnapshot> findAll() =>
      _store.collection(_collection).orderBy("created", descending: true).get();

  Future<QuerySnapshot> findByUid(String uid) => _store
      .collection(_collection)
      .where("uid", isEqualTo: uid)
      .orderBy("created", descending: true)
      .get();

  Future<void> save(Order order) =>
      _store.collection(_collection).add(order.toJson()).then((v) async {
        await v.update({"id": v.id});
      });

  Future<void> update(String id,String state) {
    return _store
        .doc("$_collection/$id")
        .update({"state" : state});
  }

}
