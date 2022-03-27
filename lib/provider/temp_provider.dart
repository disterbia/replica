import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/temp.dart';

class TempProvider{

  final _collection = "temp";
  final _store = FirebaseFirestore.instance;

  Future<QuerySnapshot> findAll() =>
      _store.collection(_collection).orderBy("created", descending: true).get();

  Future<DocumentSnapshot> save(Temp temp) =>
      _store.collection(_collection).add(temp.toJson()).then((v) async {
        await v.update({"id": v.id});
        return v.get();
      });

  Future<void> delete(String id) => _store.doc("$_collection/$id").delete();
}