import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/floor.dart';
import 'package:mallhub_flutter/presentation/bloc/floor_catalog_bloc/floor_catalog_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/store/store_grid.dart';

class FloorCatalogBlocConsumer extends StatelessWidget {
  const FloorCatalogBlocConsumer({super.key, required this.floor});

  final FloorModel floor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FloorCatalogBloc, FloorCatalogState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FloorCatalogLoading) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(30),
              child: CircularProgressIndicator(),
            ));
          }

          if (state is FloorCatalogLoadingMore) {
            return StoreGrid(
                key: const PageStorageKey<String>('floorCatalogScrollPosition'),
                isLoadingMore: true,
                isErrorOnLoadingMore: false,
                stores: state.storePaginated.data);
          }

          if (state is FloorCatalogError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<FloorCatalogBloc>()
                        .add(FetchFloorCatalog(floorId: floor.id));
                  },
                  child: const Icon(
                    Icons.restart_alt,
                    size: 30,
                  ),
                ),
                const Text("Tap to retry")
              ],
            );
          }

          if (state is FloorCatalogErrorLoadingMore) {
            return StoreGrid(
                key: const PageStorageKey<String>('floorCatalogScrollPosition'),
                isLoadingMore: false,
                isErrorOnLoadingMore: true,
                stores: state.storePaginated.data);
          }

          if (state is FloorCatalogSuccess) {
            return NotificationListener(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    if (notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent) {
                      if (state.storePaginated.nextCursor != null) {
                        context
                            .read<FloorCatalogBloc>()
                            .add(FetchMoreFloorCatalog(floorId: floor.id));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("No more store to show")));
                      }
                      return true;
                    }
                  }

                  return false;
                },
                child: StoreGrid(
                    key: const PageStorageKey<String>(
                        'floorCatalogScrollPosition'),
                    isLoadingMore: false,
                    isErrorOnLoadingMore: false,
                    stores: state.storePaginated.data));
          }

          return const SizedBox.shrink();
        });
  }
}
