class Category {
  final String? id;
  final String? name;
  final int? number;

  Category({this.id,
    this.name,
    this.number,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        number = json["number"];

}
