part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categoryModel;

  CategoryLoaded(this.categoryModel);
}

final class CategoryError extends CategoryState {
  final String error;

  CategoryError(this.error);
}
