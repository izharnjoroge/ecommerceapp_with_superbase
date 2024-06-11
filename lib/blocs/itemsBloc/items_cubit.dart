import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/repos/itemsRepo/items_repo.dart';
import 'package:meta/meta.dart';
part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemsRepo itemsRepo;
  int currentPage = 1;
  final int pageSize = 10;
  bool isLoadingMore = false;
  List<ItemModel> allItems = [];

  ItemsCubit(this.itemsRepo) : super(ItemsInitial());

  void getItemsByCategory(String categoryId, {int page = 1}) async {
    if (page == 1) {
      emit(ItemsLoading());
    } else {
      isLoadingMore = true;
      emit(ItemsLoadedMore(allItems, isLoadingMore: true));
    }

    try {
      List<ItemModel> itemModel = await itemsRepo
          .getItemsPerCategory(categoryId, page: page, pageSize: pageSize);
      if (page == 1) {
        allItems = itemModel;
        emit(ItemsLoaded(allItems));
      } else {
        allItems.addAll(itemModel);
        isLoadingMore = false;
        emit(ItemsLoadedMore(allItems));
      }
      currentPage = page;
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }

  void loadMoreItems(String categoryId) {
    if (!isLoadingMore) {
      getItemsByCategory(categoryId, page: currentPage + 1);
    }
  }

  void searchItems(String name) async {
    emit(SearchLoading());
    try {
      List<ItemModel> itemModel = await itemsRepo.getItemsByName(name);
      emit(SearchLoaded(itemModel));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
