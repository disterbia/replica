import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/model/user.dart';
import 'package:panda/repository/user_repository.dart';

class UserController extends GetxController with StateMixin {
  final UserRepositoy _userRepository = UserRepositoy();
  final principal = User().obs;
  RxBool isLoading = true.obs; //order페이지를 위해서
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  Future<void> logout() async {
    change(null,status: RxStatus.loading());

    await _userRepository.logout();
    this.principal.value = User();
    GetStorage().remove('uid');

    change(null, status: RxStatus.success());

  }

  Future<bool> join(String email, String password, String username,
      String phoneNumber) async {
    change(null,status: RxStatus.loading());

    User principal =
        await _userRepository.join(email, password, username, phoneNumber);

    if (principal.uid != null) {
      this.principal.value = principal;
      GetStorage().write("uid", principal.uid);


      change(null, status: RxStatus.success());
      return true;
    }

    change(null, status: RxStatus.success());
    return false;
  }

  Future<bool> login(String email, String password) async {
    change(null,status: RxStatus.loading());

    User principal = await _userRepository.login(email, password);

    if (principal.uid != null) {
      this.principal.value = principal;
      GetStorage().write("uid", principal.uid);

      // if(principal.uid=="chRfCQk6Z0S857O88T2A6aAKOVg2") await o.findAll();
      // else await o.findByUid(principal.uid!);

      change(null, status: RxStatus.success());
      return true;

    }

    change(null, status: RxStatus.success());
    return false;
  }

  Future<void> findById(String id) async {
    change(null,status: RxStatus.loading());
    User user = await _userRepository.findById(id);
    this.principal.value = user;

    isLoading.value=false;
    change(null, status: RxStatus.success());
  }

  Future<User> findByIdForPoint(String id) async {
    change(null,status: RxStatus.loading());

    User user = await _userRepository.findById(id);
    return user;

    change(null, status: RxStatus.success());
  }

  Future<bool> checkEmail(String email) async
  {
    change(null,status: RxStatus.loading());
    bool result = await _userRepository.checkEmail(email);
    change(null, status: RxStatus.success());
    return result;
  }

  Future<bool> checkPhoneNumber(String phoneNumber) async
  {
    change(null,status: RxStatus.loading());
    bool result = await _userRepository.checkPhoneNumber(phoneNumber);
    change(null, status: RxStatus.success());
    return result;
  }

  Future<bool> checkCode(String code) async
  {
    change(null,status: RxStatus.loading());

  bool result = await _userRepository.checkCode(code);

    change(null, status: RxStatus.success());
    return result;
}
  Future<void> updatePoint(String uid ) async {
    change(null,status: RxStatus.loading());

    await _userRepository.updatePoint(uid);
    User user = await _userRepository.findById(uid);
    this.principal.value = user;


    change(null, status: RxStatus.success());
  }

  Future<void> buyComplete(String uid ,int totalMoney,int point) async {
    change(null,status: RxStatus.loading());

    await _userRepository.buyComplete(uid,totalMoney,point);

    change(null, status: RxStatus.success());
  }

}
