import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/repos/itemsRepo/items_repo.dart';
import 'package:meta/meta.dart';
part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemsRepo itemsRepo;
  ItemsCubit(this.itemsRepo) : super(ItemsInitial());

  void getItemsByCategory(String categoryId) async {
    emit(ItemsLoading());
    try {
      List<ItemModel> itemModel =
          await itemsRepo.getItemsPerCategory(categoryId);
      emit(ItemsLoaded(itemModel));
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }
}
