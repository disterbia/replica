import 'package:get/get.dart';
import 'package:panda/model/user.dart';
import 'package:panda/repository/user_repository.dart';

class UserController extends GetxController {
  final UserRepositoy _userRepositoy = UserRepositoy();
  final principal = User().obs;
  final RxBool isLogin = false.obs;

  Future<void> logout() async {
    await _userRepositoy.logout();
    this.isLogin.value = false;
    this.principal.value = User();
  }

  Future<bool> join(String email, String password, String username,
      String phoneNumber) async {
    User principal =
        await _userRepositoy.join(email, password, username, phoneNumber);

    if (principal.uid != null) {
      this.principal.value = principal;
      this.isLogin.value= true;
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    User principal = await _userRepositoy.login(email, password);

    if (principal.uid != null) {
      this.principal.value = principal;
      this.isLogin.value= true;
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
