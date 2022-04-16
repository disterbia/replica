import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/model/user.dart';
import 'package:panda/repository/user_repository.dart';

class UserController extends GetxController {
  final UserRepositoy _userRepositoy = UserRepositoy();
  final principal = User().obs;
  final OrderController o = Get.put(OrderController());

  Future<void> logout() async {
    await _userRepositoy.logout();
    this.principal.value = User();
    GetStorage().remove('uid');

  }

  Future<bool> join(String email, String password, String username,
      String phoneNumber) async {
    User principal =
        await _userRepositoy.join(email, password, username, phoneNumber);

    if (principal.uid != null) {
      this.principal.value = principal;
      GetStorage().write("uid", principal.uid);

      if(principal.uid=="chRfCQk6Z0S857O88T2A6aAKOVg2") await o.findAll();
      else await o.findByUid(principal.uid!);
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    User principal = await _userRepositoy.login(email, password);

    if (principal.uid != null) {
      this.principal.value = principal;
      GetStorage().write("uid", principal.uid);

      if(principal.uid=="chRfCQk6Z0S857O88T2A6aAKOVg2") await o.findAll();
      else await o.findByUid(principal.uid!);
      return true;
    }
    return false;
  }

  Future<bool> checkEmail(String email) async =>
      await _userRepositoy.checkEmail(email);

  Future<bool> checkPhoneNumber(String phoneNumber) async =>
    await _userRepositoy.checkPhoneNumber(phoneNumber);


  Future<bool> checkCode(String code) async =>
    await _userRepositoy.checkCode(code);


}
