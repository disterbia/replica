class User {
  final String? uid;
  final String? email;
  final String? username;
  final String? phoneNumber;
  final String? address;
  final int? point;
  final int? totalMoney;
  final DateTime? created;
  final DateTime? updated;

  User(
      {this.uid,
      this.email,
      this.username,
      this.phoneNumber,
      this.address,
        this.point,
     this.   totalMoney,
      this.created,
      this.updated});

  User.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        username = json["username"],
        phoneNumber = json["phoneNumber"],
        email = json["email"],
        address = json["address"],
        point=json["point"],
        totalMoney = json["totalMoney"],
        created = json["created"]?.toDate(),
        updated = json["updated"]?.toDate();

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "phoneNumber": phoneNumber,
        "address": address,
        "email": email,
        "point": point,
        "totalMoney" : totalMoney,
        "created": created,
        "updated": updated,
      };
}
