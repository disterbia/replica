import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/product.dart';

class UpdateDto {
  final Product? product;

  UpdateDto({
    this.product});

  Map<String, dynamic> ProductToJson() =>
      {
        "name": product?.name,
        "comment": product?.comment,
        "price": product?.price,
        "mainImageUrl": product?.mainImageUrl,
        "category": product?.category,
        "detailImageUrl": product?.detailImageUrl,
        "updated": FieldValue.serverTimestamp()
      };
}