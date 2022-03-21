import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/order.dart';
import 'package:panda/provider/order_provider.dart';

class OrderRepository {
  final OrderProvider _orderProvider = OrderProvider();

  Future<List<Order>> findAll() async {
    QuerySnapshot querySnapshot = await _orderProvider.findAll();
    List<Order> orders = querySnapshot.docs
        .map((e) => Order.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return orders;
  }

  Future<List<Order>> findByUid(String id) async {
    QuerySnapshot querySnapshot = await _orderProvider.findByUid(id);
    List<Order> orders = querySnapshot.docs
        .map((e) => Order.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return orders;
  }

  Future<void> save(Order order) async => await _orderProvider.save(order);

  Future<void> update(String id, String state) async => await _orderProvider.update(id,state);

}
