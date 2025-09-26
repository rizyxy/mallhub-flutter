import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/model/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    print("Fetching");

    final http.Response result = await http.get(
        Uri.parse('${dotenv.get('SERVER_URL')}/products'),
        headers: {"ngrok-skip-browser-warning": "true"});

    print(result.statusCode);

    if (result.statusCode != 200) {
      throw Exception();
    }

    final response = json.decode(result.body);

    final List<ProductModel> products = (response['data'] as List)
        .map((map) => ProductModel.fromMap(map))
        .toList();

    print(products);

    return products;
  }
}
