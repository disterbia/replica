import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/model/temp.dart';
import 'package:panda/model/user.dart';
import 'package:panda/repository/temp_repository.dart';

class TempContrlloer extends GetxController{
  final TempRepository _tempRepository = TempRepository();
  final temps = <Temp>[].obs;
  final UserController u = Get.put(UserController());
  final OrderController o = Get.put(OrderController());

  @override
  void onInit() {
    super.onInit();
    findAll();
    if(GetStorage().hasData("uid")){
      User user = User(uid: GetStorage().read("uid"));
      u.principal.value=user;
    }
  }

  Future<void> findAll() async{
    List<Temp> temps = await _tempRepository.findAll();

    if(GetStorage().hasData("uid")){
      if(GetStorage().read("uid")=="chRfCQk6Z0S857O88T2A6aAKOVg2") await o.findAll();
      else await o.findByUid(GetStorage().read("uid"));
    }

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