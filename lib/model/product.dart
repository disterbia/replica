import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String? name;
  final String? comment;
  final int? price;
  final String? mainImageUrl;
  final String? category;
  final List<dynamic>? detailImageUrl;
  final List<dynamic>? size;
  final DateTime? created;
  final DateTime? updated;

  Product({this.id,
    this.name,
    this.comment,
    this.price,
    this.mainImageUrl,
    this.category,
    this.detailImageUrl,
    this.size,
    this.created,
    this.updated});

  Product.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        comment = json["comment"],
        price = json["price"],
        mainImageUrl = json["mainImageUrl"],
        category = json["category"],
        detailImageUrl = json["detailImageUrl"],
        size = json["size"],
        created = json["created"].toDate(),
        updated = json["updated"].toDate();

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "comment": comment,
        "price": price,
        "mainImageUrl": mainImageUrl,
        "category": category,
        "detailImageUrl": detailImageUrl,
        "size":size,
        "created": FieldValue.serverTimestamp(),
        "updated": FieldValue.serverTimestamp()
      };
  Map<String, dynamic> toJsonContainId() =>
      {
        "id"  : id,
        "name": name,
        "comment": comment,
        "price": price,
        "mainImageUrl": mainImageUrl,
        "category": category,
        "detailImageUrl": detailImageUrl,
        "created": FieldValue.serverTimestamp(),
        "updated": FieldValue.serverTimestamp()
      };
}
