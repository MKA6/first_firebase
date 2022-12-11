class Category {
  String? id;
  String? image;
  String? name;

  Category({this.name, this.image});

  toMap() {
    return {"name": name, "image": image};
  }
  Category.fromMap(Map<String , dynamic> map){
    name = map['name'];
    image = map['image'];
  }
}
