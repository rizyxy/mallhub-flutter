import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/paginated/product_paginated.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<ProductPaginated> fetchProduct(
      {String? nextCursor, String? searchQuery}) async {
    Uri uri = Uri.parse("${dotenv.get('SERVER_URL')}/products");

    Map<String, dynamic> queryParameters = {};

    if (nextCursor != null) {
      queryParameters['cursor'] = nextCursor;
    }

    if (searchQuery != null) {
      queryParameters['searchQuery'] = searchQuery;
    }

    uri = uri.replace(queryParameters: queryParameters);

    final response =
        await http.get(uri, headers: {'ngrok-skip-browser-warning': 'true'});

    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    }

    final decodedResponse = json.decode(response.body);

    ProductPaginated productPaginated =
        ProductPaginated.fromMap(decodedResponse);

    return productPaginated;
  }
}
