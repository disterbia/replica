import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/model/temp.dart';
import 'package:panda/repository/temp_repository.dart';
import 'package:path/path.dart' as Path;

class TempContrlloer extends GetxController with StateMixin{
  final TempRepository _tempRepository = TempRepository();
  final temps = <Temp>[].obs;
  final UserController u = Get.put(UserController());
  final OrderController o = Get.put(OrderController());

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  Future<void> findAll() async{
    change(null,status: RxStatus.loading());
    List<Temp> temps = await _tempRepository.findAll();

    if(GetStorage().hasData("uid")){
      //ßprint(GetStorage().read("uid"));
      await u.findById(GetStorage().read("uid"));
    }

    if(GetStorage().hasData("uid")){
      if(GetStorage().read("uid")=="chRfCQk6Z0S857O88T2A6aAKOVg2") await o.findAll();
      else await o.findByUid(GetStorage().read("uid"));
    }

    this.temps.value=temps;
    change(null, status: RxStatus.success());
  }

  Future<void> save(Temp newTemp) async{
    change(null,status: RxStatus.loading());

    Temp temp = await _tempRepository.save(newTemp);
    this.temps.insert(0,temp);

    change(null, status: RxStatus.success());
  }

  Future<void> delete(String id ) async {
    change(null,status: RxStatus.loading());
    await _tempRepository.delete(id);
    List<Temp> result= temps.where((temp) => temp.id != id).toList();
    temps.value=result;
    change(null, status: RxStatus.success());
  }

  List<String> urlList = [];

  Future<List<String>> uploadImageToStorage(List<XFile>? pickedFile) async {
    change(null,status: RxStatus.loading());
    for(int i =0;i<pickedFile!.length;i++) {
      if (kIsWeb) {
        Reference _reference = FirebaseStorage.instance
            .ref()
            .child('temp/images/${Path.basename(pickedFile[i].path)}');
        await _reference
            .putData(
          await pickedFile[i].readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'),
        )
            .whenComplete(() async {
          await _reference.getDownloadURL().then((value) {
            urlList.add(value);
            print(value);
          });
        });
      } else {
        print('fff');
//write a code for android or ios
      }

    }
    change(null,status: RxStatus.success());
    return urlList;
  }
}