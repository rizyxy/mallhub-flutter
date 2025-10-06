// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mallhub_flutter/data/model/product.dart';

class ProductPaginated {
  List<ProductModel> data;
  String? nextCursor;
  ProductPaginated({
    required this.data,
    this.nextCursor,
  });

  ProductPaginated copyWith({
    List<ProductModel>? data,
    String? nextCursor,
  }) {
    return ProductPaginated(
      data: data ?? this.data,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory ProductPaginated.fromMap(Map<String, dynamic> map) {
    return ProductPaginated(
      data: List<ProductModel>.from(
        (map['data'] as List<Map<String, dynamic>>).map<ProductModel>(
          (x) => ProductModel.fromMap(x),
        ),
      ),
      nextCursor:
          map['next_cursor'] != null ? map['next_cursor'] as String : null,
    );
  }

  factory ProductPaginated.fromJson(String source) =>
      ProductPaginated.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductPaginated(data: $data, nextCursor: $nextCursor)';

  @override
  bool operator ==(covariant ProductPaginated other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) && other.nextCursor == nextCursor;
  }

  @override
  int get hashCode => data.hashCode ^ nextCursor.hashCode;
}
