import 'package:get/get.dart';
import 'package:panda/model/temp.dart';
import 'package:panda/repository/temp_repository.dart';

class TempContrlloer extends GetxController{
  final TempRepository _tempRepository = TempRepository();
  final temps = <Temp>[].obs;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  Future<void> findAll() async{
    List<Temp> temps = await _tempRepository.findAll();
    this.temps.value=temps;
  }

  Future<void> save(Temp newTemp) async{
    Temp temp = await _tempRepository.save(newTemp);
    this.temps.insert(0,temp);

  }

  Future<void> delete(String id ) async {
    await _tempRepository.delete(id);
    List<Temp> result= temps.where((temp) => temp.id != id).toList();
    temps.value=result;
  }
}