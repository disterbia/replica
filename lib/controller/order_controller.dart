import 'package:get/get.dart';
import 'package:panda/repository/order_repository.dart';

import '../model/order.dart';

class OrderController extends GetxController{
  final OrderRepository _orderRepository = OrderRepository();
  final orders = <Order>[].obs;

  Future<void> findAll() async{
    List<Order> orders = await _orderRepository.findAll();
    this.orders.value=orders;
  }

  Future<void> findByUid(String id) async {
    List<Order> orders = await _orderRepository.findByUid(id);
    this.orders.value=orders;
  }

  Future<void> save(Order newOrder) async{
    await _orderRepository.save(newOrder);
  }

  Future<void> updateState(String id ,String state) async {
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
  }
}