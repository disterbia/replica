import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/user.dart';


class TotalMoneyDto {
  final int? totalMoney;
  final int? point;


  TotalMoneyDto({
    this.totalMoney,
    this.point});

  Map<String, dynamic> toJson() => {
    "totalMoney": totalMoney,
    "point": point,
    "updated": FieldValue.serverTimestamp()
  };
}