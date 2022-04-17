import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panda/model/user.dart';


class PointDto {
  final int? point;


  PointDto({
    this.point});

  Map<String, dynamic> toJson() => {
    "point": point,
    "updated": FieldValue.serverTimestamp()
  };
}