import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/store.dart';
import 'package:mallhub_flutter/presentation/bloc/store_catalog_bloc/store_catalog_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/store/store_catalog_bloc_consumer.dart';

class StoreCatalogPage extends StatelessWidget {
  const StoreCatalogPage({super.key, required this.storeModel});

  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              storeModel.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(storeModel.floor.name),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocProvider<StoreCatalogBloc>(
                create: (context) => StoreCatalogBloc()
                  ..add(FetchStoreCatalog(storeId: storeModel.id)),
                child: StoreCatalogBlocConsumer(
                  storeModel: storeModel,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
