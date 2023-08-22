import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProductModel {
  int? id;
  String? image;
  String? name;
  String? description;
  double? price;
  Color? color;
  RxInt buy = 0.obs;

  ProductModel(
      {this.id,
        this.image,
        this.name,
        this.description,
        this.price,
        this.color});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    var hexColor = json['color'].replaceAll("#", "");
    color = Color(int.parse("0xff$hexColor"));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['color'] = color;
    return data;
  }
}