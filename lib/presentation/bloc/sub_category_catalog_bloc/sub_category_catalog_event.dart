part of 'sub_category_catalog_bloc.dart';

sealed class SubCategoryCatalogEvent extends Equatable {
  const SubCategoryCatalogEvent();

  @override
  List<Object?> get props => [];
}

class FetchSubCategoryCatalog extends SubCategoryCatalogEvent {
  final int subCategoryId;

  const FetchSubCategoryCatalog({required this.subCategoryId});

  @override
  List<Object?> get props => [subCategoryId];
}

class FetchMoreSubCategoryCatalog extends SubCategoryCatalogEvent {
  final int subCategoryId;

  const FetchMoreSubCategoryCatalog({required this.subCategoryId});

  @override
  List<Object?> get props => [subCategoryId];
}
