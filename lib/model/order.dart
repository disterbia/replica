import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/model/product.dart';
import 'package:panda/model/user.dart';

import '../controller/user_controller.dart';

class Order {
  final String? id;
  final String? uid;
  final User? user;
  final Product? product;
  final String? payName;
  final String? address;
  final String? memo;
  final int? payPrice;
  String? state;
  final DateTime? created;
  final DateTime? updated;

  Order(
      {this.id,
      this.uid,
      this.user,
      this.product,
      this.payName,
      this.address,
      this.memo,
      this.payPrice,
      this.state,
      this.created,
      this.updated});

  Order.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        uid = json["uid"],
        user = User.fromJson(json["user"]),
        product = Product.fromJson(json["product"]),
        payName = json["pay_name"],
        address = json["address"],
        memo = json["memo"],
        payPrice = json["payPrice"],
        state = json["state"],
        created = json["created"].toDate(),
        updated = json["updated"].toDate();

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "user": Get.find<UserController>().principal.value.toJson(),
        "product":
            Get.find<ProductController>().product.value.toJsonContainId(),
        "pay_name": payName,
        "address": address,
        "memo": memo,
        "payPrice": payPrice,
        "state": state,
        "created": FieldValue.serverTimestamp(),
        "updated": FieldValue.serverTimestamp()
      };
}
