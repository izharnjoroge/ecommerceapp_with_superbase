part of 'items_cubit.dart';

@immutable
sealed class ItemsState {}

final class ItemsInitial extends ItemsState {}

final class ItemsLoading extends ItemsState {}

final class ItemsLoadingMore extends ItemsState {}

final class ItemsLoaded extends ItemsState {
  final List<ItemModel> itemModel;

  ItemsLoaded(this.itemModel);
}

class ItemsLoadedMore extends ItemsState {
  final List<ItemModel> itemModelMore;
  final bool isLoadingMore;

  ItemsLoadedMore(this.itemModelMore, {this.isLoadingMore = false});
}

final class ItemsError extends ItemsState {
  final String error;

  ItemsError(this.error);
}

final class SearchLoading extends ItemsState {}

final class SearchLoaded extends ItemsState {
  final List<ItemModel> itemModel;

  SearchLoaded(this.itemModel);
}

final class SearchError extends ItemsState {
  final String error;

  SearchError(this.error);
}
