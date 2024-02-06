import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/models/category_model.dart';
import 'package:ecommerceapp/repos/categoryRepo/category_repo.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo categoryRepo;
  CategoryCubit(this.categoryRepo) : super(CategoryInitial());

  void getCategories() async {
    emit(CategoryLoading());
    try {
      List<CategoryModel> categoryModel = await categoryRepo.getCategories();
      emit(CategoryLoaded(categoryModel));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
