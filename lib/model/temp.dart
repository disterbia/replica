import 'package:cloud_firestore/cloud_firestore.dart';

class Temp {
  final String? id;
  final String? url;
  final DateTime? created;

  Temp({this.id, this.url, this.created});

  Temp.fromJson(Map<String, dynamic> json)
      : url = json["url"],
        id = json["id"],
        created = json["created"].toDate();

  Map<String, dynamic> toJson() => {
        "url": url,
        "created": FieldValue.serverTimestamp(),
      };
}
