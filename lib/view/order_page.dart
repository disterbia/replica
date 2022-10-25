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
import 'package:js/js.dart';

import 'dart:js' as js;

@JS('functionName')
external set _functionName(void Function() f);

class OrderPage extends GetView<OrderController> {


  OrderPage({this.param});
  final _formKey = GlobalKey<FormState>();
  final _zonecode = TextEditingController();
  final _address = TextEditingController();
  final _detailAdress = TextEditingController();
  final _extraAdress = TextEditingController();
  final _payName = TextEditingController();
  final _memo = TextEditingController();
  final phone = TextEditingController();
  ProductController p = Get.put(ProductController());
  OrderController o = Get.put(OrderController());
  UserController u = Get.put(UserController());
  RxBool pressed = false.obs;
  RxInt nowPrice =0.obs;
  RxInt nowPoint=0.obs;
  RxInt realPoint=0.obs; // 클릭할떄 값을 바꾸기위해
  String? param;
  bool isFisrtClick=true;
  bool disableMultipleClick =false;
  BuildContext? _context;

  void _someDartFunction() {
    js.JsObject obj = js.JsObject.fromBrowserObject(js.context['add']);//주소선택했을때 이걸 어떻게 재호출할까..
    _zonecode.text=obj['zonecode'].toString();
    _address.text=obj['addr'].toString();
    _extraAdress.text=obj['extraAddr'].toString();
    print(obj['data'].toString());
  }

  @override
  Widget build(BuildContext context) {
    _functionName = allowInterop(_someDartFunction);
    _context=context;
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
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          CustomLogo(),
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            child: Text(
                              "주문 페이지",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _orderForm(),
                        ],
                      ),
                    ),
                  );

                }
  }),
        onLoading: Center(
            child: Container(
                height: 50, width: 50, child: CircularProgressIndicator()))
    );
  }
  Widget _orderForm(){
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Text(p.product.value.name!),
              Text(p.product.value.comment!),
              p.product.value.size!.first != ""?Text("옵션:${GetStorage().read("option")}"):Container(),
              Text(NumberFormat("###,###,### 원")
                  .format(p.product.value.price!)),
              SizedBox(height: 40,),
              Row(
                children: [
                  Container(width: 200,
                    child: CustomTextFormField(
                        hint: "배송지",
                        disable: true,
                      controller: _zonecode,
                    ),
                  ),
                  Container(width: 100,
                    child: TextButton(
                        onPressed: ()  {
                          var data=js.context.callMethod("aa");
                        },
                        child: Text("배송지 찾기")),
                  ),
                  SizedBox(width: 200,)
                ],
              ),
              CustomTextFormField(
                  hint: "주소",
                  disable: true,
                  controller: _address,
                  ),
              Row(
                children: [
                  Container(width: 240,
                    child: CustomTextFormField(
                        hint: "상세주소",
                        controller: _detailAdress,
                        ),
                  ),
                  SizedBox(width: 20,),
                  Container(width: 240,
                    child: CustomTextFormField(
                        hint: "주소참고",
                        disable: true,
                        controller: _extraAdress,
                        ),
                  ),
                ],
              ),
              CustomTextFormField(
                  hint: "입금자명",
                  controller: _payName,
                  funValidator: validateOrder()),
              CustomTextFormField(
                  hint: "수령인 전화번호",
                  controller: phone,
                  funValidator: validatePhoneNumber()),
              Text("입금계좌 : 신한은행 123-456789-000"),
              Row(
                children: [
                  Text(
                      "보유 포인트: ${NumberFormat("###,###,### 원").format(nowPoint.value)}"),
                  TextButton(
                    onPressed: () {
                        // print(FirebaseAuth.instance.currentUser); //새로고침후 몇초간 null 이라서 보안규칙위배배
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
                hint: "요구사항을 말씀해 주세요.",
                controller: _memo,
              ),
              CustomElevatedButton(
                  text: "주문완료",
                  funPageRoute: () async {
                    if (!disableMultipleClick&&_formKey.currentState!.validate()&&GetStorage().read("product")==p.product.value.id) {
                      disableMultipleClick=true;
                      Order order = Order(
                          uid: u.principal.value.uid,
                          user: u.principal.value,
                          product: p.product.value,
                          address: _zonecode.text+_address.text+_extraAdress.text+_detailAdress.text,
                          payName: _payName.text,
                          phone: int.parse(phone.text),
                          memo: _memo.text,
                          payPrice: nowPrice.value,
                          state: "입금확인중");
                      pressed.value
                          ? await u
                          .updatePoint(u.principal.value.uid!)
                          : null;
                      GetStorage().remove("option");
                      await o.save(order);
                      await o.findByUid(u.principal.value.uid!);
                      Router.neglect(_context!, () {
                        _context!.go("/mypage");
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
