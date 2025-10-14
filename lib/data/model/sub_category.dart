// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubCategoryModel {
  int id;
  int categoryId;
  String name;
  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  SubCategoryModel copyWith({
    int? id,
    int? categoryId,
    String? name,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
    );
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['id'] as int,
      categoryId: map['category_id'] as int,
      name: map['name'] as String,
    );
  }

  factory SubCategoryModel.fromJson(String source) =>
      SubCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubCategoryModel(id: $id, categoryId: $categoryId, name: $name)';

  @override
  bool operator ==(covariant SubCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categoryId == categoryId &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ categoryId.hashCode ^ name.hashCode;
}
