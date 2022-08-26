import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/dto/point_dto.dart';
import 'package:panda/dto/total_money_dto.dart';
import 'package:panda/model/user.dart';

class UserProvider {
  final _collection = "users";
  final _store = FirebaseFirestore.instance;

  Future<QuerySnapshot> login(String uid) =>
      _store.collection(_collection).where("uid", isEqualTo: uid).get();

  Future<QuerySnapshot> findById(String id) =>
      _store.collection(_collection).where("uid", isEqualTo: id).get();

  Future<DocumentReference> join(User user) =>
      _store.collection(_collection).add(user.toJson());

  Future<QuerySnapshot> checkEmail(String email) =>
      _store.collection(_collection).where("email", isEqualTo: email).get();

  Future<void> updatePoint(String uid) {
    String id;
    try{
      return _store
          .collection(_collection)
          .where("uid", isEqualTo: uid)
          .get()
          .then((v) async {
        id = v.docs.first.id;
        return await _store
            .doc("$_collection/$id")
            .update(PointDto(point: 0).toJson());
      });
    }
    catch(e){
      print(e);
    }
      return Future(() => null);
  }

  Future<void> buyComplete(String uid , int totalMoney, int point) {
    String id;
    return _store
        .collection(_collection)
        .where("uid", isEqualTo: uid)
        .get()
        .then((v) async {
      id = v.docs.first.id;
      return await _store
          .doc("$_collection/$id")
          .update(TotalMoneyDto(totalMoney: totalMoney,point: point).toJson());
    });
  }
}
