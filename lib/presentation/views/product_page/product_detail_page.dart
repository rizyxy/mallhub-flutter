import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/model/product.dart';
import 'package:mallhub_flutter/presentation/views/store_page/store_catalog_page.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 400,
                child: Image.network(
                  errorBuilder: (context, child, stackTrace) {
                    return Placeholder();
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        // Optionally calculate the progress percentage
                        value: loadingProgress?.expectedTotalBytes != null
                            ? loadingProgress!.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  "${dotenv.get('SERVER_STORAGE')}/${productModel.productImages[0]}",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                productModel.name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Rp ${productModel.price.toString()}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoreCatalogPage(
                              storeModel: productModel.store)));
                },
                child: Text(
                  productModel.store.name,
                  style: const TextStyle(
                      decoration: TextDecoration.underline, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(productModel.description)
            ],
          ),
        ),
      )),
    );
  }
}
