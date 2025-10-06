// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductModel {
  int id;
  String name;
  String description;
  double price;
  int storeId;
  String storeName;
  List<String> productImages;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.storeId,
    required this.storeName,
    required this.productImages,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    int? storeId,
    String? storeName,
    List<String>? productImages,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      productImages: productImages ?? this.productImages,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      storeId: map['store']['id'] as int,
      storeName: map['store']['name'] as String,
      productImages: (map['product_images'] as List<Map<String, dynamic>>)
          .map((img) => img['url'])
          .toList() as List<String>,
    );
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, storeId: $storeId, storeName: $storeName, productImages: $productImages)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.storeId == storeId &&
        other.storeName == storeName &&
        listEquals(other.productImages, productImages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        storeId.hashCode ^
        storeName.hashCode ^
        productImages.hashCode;
  }
}
