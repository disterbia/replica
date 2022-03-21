import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/controller/order_controller.dart';

class MyPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    OrderController o = Get.put(OrderController());
    return Scaffold(body: ListView.separated(itemBuilder: (context, index) {
      return Row(
        children: [
          Text(o.orders[index].user!.username!),
          Text(o.orders[index].product!.name!),
          Text(o.orders[index].product!.price!),
          Text(o.orders[index].address!),
          Text(o.orders[index].payName!),
          Text(o.orders[index].state!),
        ],
      );
    }, separatorBuilder: (context,index)=>Divider(), itemCount: o.orders.length),);
  }
}
