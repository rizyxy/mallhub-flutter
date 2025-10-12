import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/model/floor.dart';
import 'package:http/http.dart' as http;

class FloorRepository {
  Future<List<FloorModel>> fetchFloor() async {
    Uri uri = Uri.parse("${dotenv.get('SERVER_URL')}/floors");

    final response =
        await http.get(uri, headers: {'ngrok-skip-browser-warning': 'true'});

    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    }

    final decodedResponse = json.decode(response.body);

    List<FloorModel> floors = (decodedResponse as List)
        .map((map) => FloorModel.fromMap(map))
        .toList();

    return floors;
  }
}
