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
