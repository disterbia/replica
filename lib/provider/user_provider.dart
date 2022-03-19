import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/user.dart';

class UserProvider {
  final _collection = "users";
  final _store = FirebaseFirestore.instance;

  Future<QuerySnapshot> login(String uid) => _store
      .collection(_collection)
      .where("uid", isEqualTo: uid)
      .get();

  Future<DocumentReference> join(User user) =>
      _store.collection(_collection).add(user.toJson());

  Future<QuerySnapshot> checkEmail(String email) => _store
      .collection(_collection)
      .where("email", isEqualTo: email)
      .get();
}
