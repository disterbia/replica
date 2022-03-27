import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/temp.dart';
import 'package:panda/provider/temp_provider.dart';

class TempRepository{

  final TempProvider _tempProvider = TempProvider();

  Future<List<Temp>> findAll() async {
    QuerySnapshot querySnapshot = await _tempProvider.findAll();
    List<Temp> temps = querySnapshot.docs
        .map((e) => Temp.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return temps;
  }

  Future<Temp> save(Temp temp) async {
    DocumentSnapshot result = await _tempProvider.save(temp);
    return Temp.fromJson(result.data() as Map<String, dynamic>);
  }


  Future<void> delete(String id) async{
    await _tempProvider.delete(id);
  }
}