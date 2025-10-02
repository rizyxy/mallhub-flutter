import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/store/store_grid.dart';

class StoreBlocConsumer extends StatelessWidget {
  const StoreBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreBloc, StoreState>(
      listener: (context, state) async {
        if (state is StoreError || state is StoreErrorLoadingMore) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("An error has occured")));
        }
      },
      builder: (context, state) {
        if (state is StoreLoading) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(30),
            child: CircularProgressIndicator(),
          ));
        }

        if (state is StoreError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.read<StoreBloc>().add(FetchStore());
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

        if (state is StoreLoadingMore) {
          return StoreGrid(
            key: const PageStorageKey<String>('storeGridScrollPosition'),
            isLoadingMore: true,
            isErrorOnLoadingMore: false,
            stores: state.stores,
          );
        }

        if (state is StoreErrorLoadingMore) {
          return StoreGrid(
            key: const PageStorageKey<String>('storeGridScrollPosition'),
            isLoadingMore: false,
            isErrorOnLoadingMore: true,
            stores: state.stores,
          );
        }

        if (state is StoreSuccess) {
          return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
                  context.read<StoreBloc>().add(FetchMoreStore());
                }

                return false;
              },
              child: StoreGrid(
                key: const PageStorageKey<String>('storeGridScrollPosition'),
                isLoadingMore: false,
                isErrorOnLoadingMore: false,
                stores: state.stores,
              ));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
