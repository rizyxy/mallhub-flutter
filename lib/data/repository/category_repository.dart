import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  Future<List<CategoryModel>> fetchCategory() async {
    Uri uri = Uri.parse("${dotenv.get('SERVER_URL')}/categories");

    final response =
        await http.get(uri, headers: {'ngrok-skip-browser-warning': 'true'});

    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    }

    final decodedResponse = json.decode(response.body);

    List<CategoryModel> categories = (decodedResponse as List)
        .map((map) => CategoryModel.fromMap(map))
        .toList();

    return categories;
  }
}
