import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/model/subcategory.dart';
import 'package:http/http.dart' as http;

class SubCategoryRepository {
  Future<List<SubCategoryModel>> fetchSubCategory(
      {required int categoryId}) async {
    Uri uri = Uri.parse(
        "${dotenv.get('SERVER_URL')}/category/$categoryId/subcategories");

    final response =
        await http.get(uri, headers: {'ngrok-skip-browser-warning': 'true'});

    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    }

    final decodedResponse = json.decode(response.body);

    List<SubCategoryModel> subCategories = (decodedResponse as List)
        .map((map) => SubCategoryModel.fromMap(map))
        .toList();

    return subCategories;
  }
}
