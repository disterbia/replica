import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/components/custom_elevated_button.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';

import '../model/order.dart';
import '../util/validator_util.dart';
import 'my_page.dart';

class OrderPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _address = TextEditingController();
  final _payName = TextEditingController();
  ProductController p = Get.find();
  OrderController o = Get.put(OrderController());
  UserController u = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text(p.product.value.name!),
            Text(p.product.value.comment!),
            Text(p.product.value.price!),
            CustomTextFormField(
                hint: "배송지",
                controller: _address,
                funValidator: validateUsername()),
            CustomTextFormField(
                hint: "입금자명",
                controller: _payName,
                funValidator: validateUsername()),
            CustomElevatedButton(
                text: "주문완료",
                funPageRoute: () async {
                  Order order = Order(
                      uid: u.principal.value.uid,
                      user: u.principal.value,
                      product: p.product.value,
                      address: _address.text,
                      payName: _payName.text,
                      state: "입금확인중");
                  await o.save(order);
                  await o.findByUid(u.principal.value.uid!);
                  Get.to(() => MyPage());
                })
          ],
        ),
      ),
    );
  }
}
