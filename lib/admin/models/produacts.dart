import 'dart:convert';

class Produacts {
  String? id;
  String? catId;
  String? imageUrl;
  String? name;
  String? description;
  String? price;

  Produacts({
    this.id,
    this.catId,
    this.imageUrl,
    this.name,
    this.description,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'catId': catId,
      'imageUrl' : imageUrl,
      'name' : name,
      'description' :description,
      'price':price,
    };
  }

  Map<String, dynamic> toMap1() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (catId != null) {
      result.addAll({'catId': catId});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (price != null) {
      result.addAll({'price': price});
    }
    return result;
  }

  factory Produacts.fromMap(Map<String, dynamic> map) {
    return Produacts(
      id: map['id'] != null ? map['id'] as String : null,
      catId: map['catId'] != null ? map['catId'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Produacts.fromJson(String source) =>
      Produacts.fromMap(json.decode(source));
}
