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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("An error has occured")));
        }
      },
      builder: (context, state) {
        if (state is StoreLoading) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(30),
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
                child: Icon(
                  Icons.restart_alt,
                  size: 30,
                ),
              ),
              Text("Tap to retry")
            ],
          );
        }

        if (state is StoreLoadingMore) {
          return StoreGrid(
            key: PageStorageKey<String>('storeGridScrollPosition'),
            isLoadingMore: true,
            isErrorOnLoadingMore: false,
          );
        }

        if (state is StoreErrorLoadingMore) {
          return StoreGrid(
            key: PageStorageKey<String>('storeGridScrollPosition'),
            isLoadingMore: false,
            isErrorOnLoadingMore: true,
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
                key: PageStorageKey<String>('storeGridScrollPosition'),
                isLoadingMore: false,
                isErrorOnLoadingMore: false,
              ));
        }

        return SizedBox.shrink();
      },
    );
  }
}
