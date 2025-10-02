// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mallhub_flutter/data/model/store.dart';

class StorePaginated {
  List<StoreModel> data;
  String? nextCursor;
  StorePaginated({
    required this.data,
    this.nextCursor,
  });

  StorePaginated copyWith({
    List<StoreModel>? data,
    String? nextCursor,
  }) {
    return StorePaginated(
      data: data ?? this.data,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory StorePaginated.fromMap(Map<String, dynamic> map) {
    return StorePaginated(
      data: List<StoreModel>.from(
        (map['data'] as List).map<StoreModel>(
          (x) => StoreModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      nextCursor:
          map['next_cursor'] != null ? map['next_cursor'] as String : null,
    );
  }

  factory StorePaginated.fromJson(String source) =>
      StorePaginated.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StorePaginated(data: $data, nextCursor: $nextCursor)';

  @override
  bool operator ==(covariant StorePaginated other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) && other.nextCursor == nextCursor;
  }

  @override
  int get hashCode => data.hashCode ^ nextCursor.hashCode;
}
