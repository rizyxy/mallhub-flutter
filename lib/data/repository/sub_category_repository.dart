import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/model/sub_category.dart';
import 'package:http/http.dart' as http;
import 'package:mallhub_flutter/data/paginated/product_paginated.dart';

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

  Future<ProductPaginated> fetchSubCategoryCatalog(
      {required int subCategoryId, String? cursor}) async {
    Uri uri = Uri.parse(
        "${dotenv.get('SERVER_URL')}/subcategory/$subCategoryId/products");

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
