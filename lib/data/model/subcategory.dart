// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubCategory {
  int id;
  int categoryId;
  String name;
  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  SubCategory copyWith({
    int? id,
    int? categoryId,
    String? name,
  }) {
    return SubCategory(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
    );
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['id'] as int,
      categoryId: map['category_id'] as int,
      name: map['name'] as String,
    );
  }

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubCategory(id: $id, categoryId: $categoryId, name: $name)';

  @override
  bool operator ==(covariant SubCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categoryId == categoryId &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ categoryId.hashCode ^ name.hashCode;
}
