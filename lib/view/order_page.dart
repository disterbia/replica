import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:panda/components/custom_elevated_button.dart';
import 'package:panda/components/custom_logo.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:panda/controller/order_controller.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';

import '../model/order.dart';
import '../util/validator_util.dart';
import 'my_page.dart';

class OrderPage extends GetView<ProductController> {
  OrderPage({this.param});
  final _formKey = GlobalKey<FormState>();
  final _address = TextEditingController();
  final _payName = TextEditingController();
  final _memo = TextEditingController();
  ProductController p = Get.put(ProductController());
  OrderController o = Get.put(OrderController());
  UserController u = Get.put(UserController());
  RxBool pressed = false.obs;
  RxInt nowPrice =0.obs;
  RxInt nowPoint=0.obs;
  RxInt realPoint=0.obs; // 클릭할떄 값을 바꾸기위해
  String? param;
  bool isFisrtClick=true;

  @override
  Widget build(BuildContext context) {
    p.findById(param!);
    u.findById(GetStorage().read("uid"));
    return controller.obx(
        (state) => Obx(
              (){
                if (p.isLoading.value||u.isLoading.value) {
                  return Center(
                      child: Container(
                          height: 50, width: 50, child: CircularProgressIndicator()));
                }
                else {
                  if(isFisrtClick) {
                    nowPrice.value = p.product.value.price!;
                    nowPoint.value=u.principal.value.point!;
                    realPoint.value=u.principal.value.point!;
                  }
                  return Scaffold(
                body: Form(
                  key: _formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomLogo(),
                            SizedBox(
                              height: 50,
                            ),
                            Text(p.product.value.name!),
                            Text(p.product.value.comment!),
                            Text(NumberFormat("###,###,### 원")
                                .format(p.product.value.price!)),
                            CustomTextFormField(
                                hint: "배송지",
                                controller: _address,
                                funValidator: validateUsername()),
                            CustomTextFormField(
                                hint: "입금자명",
                                controller: _payName,
                                funValidator: validateUsername()),
                            Text("입금계좌 : 신한은행 123-456789-000"),
                            Row(
                              children: [
                                Text(
                                    "보유 포인트: ${NumberFormat("###,###,### 원").format(nowPoint.value)}"),
                                TextButton(
                                  onPressed: () {
                                    print(FirebaseAuth.instance.currentUser); //새로고침후 몇초간 null 이라서 보안규칙위배배
                                    isFisrtClick=false;
                                    pressed.value = !pressed.value;
                                    nowPoint.value= !pressed.value ? realPoint.value:0;
                                    nowPrice.value = !pressed.value
                                        ? p.product.value.price!
                                        : p.product.value.price! -
                                            u.principal.value.point!;
                                  },
                                  child: Text(
                                    "사용하기",
                                    style: TextStyle(
                                        color: pressed.value
                                            ? Colors.red
                                            : Colors.blue),
                                  ),
                                )
                              ],
                            ),
                            Text(
                                "입금금액 : ${NumberFormat("###,###,### 원").format(nowPrice.value)}"),
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
                                      memo: _memo.text,
                                      payPrice: nowPrice.value,
                                      state: "입금확인중");
                                  pressed.value ? await u.updatePoint(
                                      u.principal.value.uid!):null;

                                  await o.save(order);
                                  await o.findByUid(u.principal.value.uid!);
                                  context.go("/mypage");
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
                }
  }),
        // onLoading: Center(
        //     child: Container(
        //         height: 50, width: 50, child: CircularProgressIndicator()))
    );
  }
}
