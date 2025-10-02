import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/paginated/store_paginated.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
  Future<StorePaginated> fetchStore({String? nextCursor}) async {
    Uri uri = Uri.parse("${dotenv.get('SERVER_URL')}/stores");

    if (nextCursor != null) {
      uri = uri.replace(queryParameters: {'cursor': nextCursor});
    }

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    }

    final decodedResponse = json.decode(response.body);

    StorePaginated storePaginated = StorePaginated.fromMap(decodedResponse);

    return storePaginated;
  }
}
