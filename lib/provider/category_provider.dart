import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/temp.dart';

class CategoryProvider{

  final _collection = "category";
  final _store = FirebaseFirestore.instance;

  Future<QuerySnapshot> findAll() =>
      _store.collection(_collection).orderBy("id", descending: true).get();
}