import 'package:get/get.dart';
import 'package:panda/repository/order_repository.dart';

import '../model/order.dart';

class OrderController extends GetxController with StateMixin{
  final OrderRepository _orderRepository = OrderRepository();
  final orders = <Order>[].obs;
  RxBool isLoding = true.obs;


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