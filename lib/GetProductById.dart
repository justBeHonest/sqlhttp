// To parse this JSON data, do
//
//     final getProductById = getProductByIdFromJson(jsonString);

import 'dart:convert';

GetProductById getProductByIdFromJson(String str) =>
    GetProductById.fromJson(json.decode(str));

String getProductByIdToJson(GetProductById data) => json.encode(data.toJson());

class GetProductById {
  GetProductById({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.price,
    required this.createdDate,
  });

  int id;
  String name;
  String description;
  int stock;
  int price;
  DateTime createdDate;

  factory GetProductById.fromJson(Map<String, dynamic> json) => GetProductById(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        stock: json["stock"],
        price: json["price"],
        createdDate: DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "stock": stock,
        "price": price,
        "createdDate": createdDate.toIso8601String(),
      };
}
