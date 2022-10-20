import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panda/repository/order_repository.dart';

import '../model/order.dart';

class OrderController extends GetxController with StateMixin{
  final OrderRepository _orderRepository = OrderRepository();
  final orders = <Order>[].obs;
  RxBool isLoding = true.obs;

  @override
  void onInit() {
    super.onInit();
    String? uid= GetStorage().read("uid");
    if(uid!=null&&uid=="chRfCQk6Z0S857O88T2A6aAKOVg2"){
      findAll();
    }else if(uid!=null){
      findByUid(uid);
    }
    change(null, status: RxStatus.success());
  }

  Future<void> findAll() async{
    change(null,status: RxStatus.loading());

    List<Order> orders = await _orderRepository.findAll();
    this.orders.value=orders;
    isLoding.value=false;
    change(null, status: RxStatus.success());
  }

  Future<void> findByUid(String id) async {
    change(null,status: RxStatus.loading());

    List<Order> orders = await _orderRepository.findByUid(id);
    this.orders.value=orders;
    isLoding.value=false;
    change(null, status: RxStatus.success());
  }

  Future<void> save(Order newOrder) async{
    change(null,status: RxStatus.loading());

    await _orderRepository.save(newOrder);

    change(null, status: RxStatus.success());
  }

  Future<void> updateState(String id ,String state) async {
    change(null,status: RxStatus.loading());

    await _orderRepository.update(id,state);
    orders.value=orders.map((e) {
      if(e.id == id){
        e.state=state;
        return e;
      }else {
        return e;
      }
    }
    ).toList();

    change(null, status: RxStatus.success());
  }
}