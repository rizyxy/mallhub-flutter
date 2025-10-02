import 'package:mallhub_flutter/data/model/store.dart';

class StoreRepository {
  Future<List<StoreModel>> fetchStore() async {
    //Mock Data
    List<StoreModel> storeDb = [
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
      StoreModel(
          id: 1,
          name: 'Pull and Bear',
          logoUrl: 'www.google.com',
          floorId: 1,
          floorName: '1'),
    ];

    //Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    storeDb.shuffle();

    return storeDb.getRange(0, 8).toList();
  }
}
