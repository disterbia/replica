import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panda/components/custom_elevated_button.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/view/temp_page.dart';

import '../model/order.dart';
import '../util/validator_util.dart';
import 'my_page.dart';

class OrderPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _address = TextEditingController();
  final _payName = TextEditingController();
  final _memo = TextEditingController();
  ProductController p = Get.find();
  OrderController o = Get.put(OrderController());
  UserController u = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(onTap:()=> Get.to(()=>TempPage()),
                    child: Container(height: 100,
                      child: Image.asset("assets/logo.png"),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Text(p.product.value.name!),
                  Text(p.product.value.comment!),
                  Text(NumberFormat("###,###,### 원").format(int.parse(p.product.value.price!))),
                  CustomTextFormField(
                      hint: "배송지",
                      controller: _address,
                      funValidator: validateUsername()),
                  CustomTextFormField(
                      hint: "입금자명",
                      controller: _payName,
                      funValidator: validateUsername()),
                  Text("입금계좌 : 신한은행 123-456789-000"),
                  Text("입금금액 : ${NumberFormat("###,###,### 원").format(int.parse(p.product.value.price!))}"),
                  CustomTextFormField(
                      hint: "상품 색상 및 옵션등을 말씀해 주세요.",
                      controller: _memo,
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
          ),
        ),
      ),
    );
  }
}
