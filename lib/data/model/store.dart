// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mallhub_flutter/data/model/floor.dart';

class StoreModel {
  int id;
  String name;
  String logoUrl;
  FloorModel floor;
  StoreModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.floor,
  });

  StoreModel copyWith({
    int? id,
    String? name,
    String? logoUrl,
    FloorModel? floor,
  }) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      floor: floor ?? this.floor,
    );
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] as int,
      name: map['name'] as String,
      logoUrl: map['logo_url'] as String,
      floor: FloorModel.fromMap(map['floor'] as Map<String, dynamic>),
    );
  }

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreModel(id: $id, name: $name, logoUrl: $logoUrl, floor: $floor)';
  }

  @override
  bool operator ==(covariant StoreModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.logoUrl == logoUrl &&
        other.floor == floor;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ logoUrl.hashCode ^ floor.hashCode;
  }
}
