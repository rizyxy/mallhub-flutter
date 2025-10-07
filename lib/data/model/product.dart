// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mallhub_flutter/data/model/store.dart';

class ProductModel {
  int id;
  String name;
  String description;
  double price;
  StoreModel store;
  List<String> productImages;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.store,
    required this.productImages,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    StoreModel? store,
    List<String>? productImages,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      store: store ?? this.store,
      productImages: productImages ?? this.productImages,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      store: StoreModel.fromMap(map['store'] as Map<String, dynamic>),
      productImages: (map['product_images'] as List)
          .map((img) => (img['url'] as String))
          .toList(),
    );
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, store: $store, productImages: $productImages)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.store == store &&
        listEquals(other.productImages, productImages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        store.hashCode ^
        productImages.hashCode;
  }
}
