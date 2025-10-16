import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/store_search_bloc/store_search_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/store/store_grid.dart';

class StoreSearchBlocConsumer extends StatelessWidget {
  const StoreSearchBlocConsumer(
      {super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreSearchBloc, StoreSearchState>(
      listener: (context, state) {
        if (state is StoreSearchError || state is StoreSearchErrorLoadingMore) {
          String? errorMessage;

          if (state is StoreSearchError) {
            errorMessage = state.errorMessage;
          } else if (state is StoreSearchErrorLoadingMore) {
            errorMessage = state.errorMessage;
          }

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage ?? "An error has occured")));
        }
      },
      builder: (context, state) {
        if (state is StoreSearchLoading) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                Text("Searching for ${textEditingController.value.text}")
              ],
            ),
          ));
        }

        if (state is StoreSearchLoadingMore) {
          return StoreGrid(
            isLoadingMore: true,
            isErrorOnLoadingMore: false,
            stores: state.storePaginated.data,
          );
        }

        if (state is StoreSearchError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.read<StoreSearchBloc>().add(FetchSearchedStore(
                      searchQuery: textEditingController.value.text));
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

        if (state is StoreSearchErrorLoadingMore) {
          return StoreGrid(
            isLoadingMore: false,
            isErrorOnLoadingMore: true,
            stores: state.storePaginated.data,
          );
        }

        if (state is StoreSearchSuccess) {
          if (state.storePaginated.data.isNotEmpty) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent) {
                  if (state.storePaginated.nextCursor != null) {
                    context.read<StoreSearchBloc>().add(FetchMoreSearchedStore(
                        searchQuery: textEditingController.value.text));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("No more stores to show")));
                  }

                  return true;
                }

                return false;
              },
              child: StoreGrid(
                isLoadingMore: false,
                isErrorOnLoadingMore: false,
                stores: state.storePaginated.data,
              ),
            );
          } else {
            return const Center(
              child: Text("No matching stores found"),
            );
          }
        }

        return const Center(
          child: Text("You haven't searched anything"),
        );
      },
    );
  }
}
