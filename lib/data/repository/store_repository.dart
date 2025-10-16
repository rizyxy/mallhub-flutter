import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/paginated/product_paginated.dart';
import 'package:mallhub_flutter/data/paginated/store_paginated.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
  Future<StorePaginated> fetchStore(
      {String? nextCursor, String? searchQuery}) async {
    Uri uri = Uri.parse("${dotenv.get('SERVER_URL')}/stores");
    Map<String, dynamic> queryParameters = {};

    if (nextCursor != null) {
      queryParameters['cursor'] = nextCursor;
    }

    if (searchQuery != null) {
      queryParameters['searchQuery'] = searchQuery;
    }

    uri = uri.replace(queryParameters: queryParameters);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    }

    final decodedResponse = json.decode(response.body);

    StorePaginated storePaginated = StorePaginated.fromMap(decodedResponse);

    return storePaginated;
  }

  Future<ProductPaginated> fetchStoreCatalog(
      {required int storeId, String? nextCursor}) async {
    Uri uri = Uri.parse("${dotenv.get('SERVER_URL')}/store/$storeId/products");

    if (nextCursor != null) {
      uri = uri.replace(queryParameters: {'cursor': nextCursor});
    }

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    }

    final decodedResponse = json.decode(response.body);

    ProductPaginated productPaginated =
        ProductPaginated.fromMap(decodedResponse);

    return productPaginated;
  }
}
