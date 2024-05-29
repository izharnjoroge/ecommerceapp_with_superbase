part of 'items_cubit.dart';

@immutable
sealed class ItemsState {}

final class ItemsInitial extends ItemsState {}

final class ItemsLoading extends ItemsState {}

final class ItemsLoaded extends ItemsState {
  final List<ItemModel> itemModel;

  ItemsLoaded(this.itemModel);
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
