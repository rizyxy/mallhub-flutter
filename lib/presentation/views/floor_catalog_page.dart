import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/floor.dart';
import 'package:mallhub_flutter/presentation/bloc/floor_catalog_bloc/floor_catalog_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/floor/floor_catalog_bloc_consumer.dart';

class FloorCatalogPage extends StatelessWidget {
  const FloorCatalogPage({super.key, required this.floor});

  final FloorModel floor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FloorCatalogBloc>(
      create: (context) =>
          FloorCatalogBloc()..add(FetchFloorCatalog(floorId: floor.id)),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                floor.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: FloorCatalogBlocConsumer(
                floor: floor,
              ))
            ],
          ),
        )),
      ),
    );
  }
}
