class ProductModel {
  String id;
  String name;
  String? description;
  double price;
  List<String>? productImages;
  String storeName;
  String storeId;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.storeName,
      required this.storeId,
      this.description,
      this.productImages});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        id: map['id'].toString(),
        name: map['name'],
        description: map['description'],
        price: (map['price'] as num).toDouble(),
        productImages: (map['product_images'] as List)
            .map((img) => img['url'] as String)
            .toList(),
        storeName: map['store']['name'],
        storeId: map['store']['id'].toString());
  }
}
