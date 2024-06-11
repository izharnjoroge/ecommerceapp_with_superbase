import 'package:ecommerceapp/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemsRepo {
  final supabase = Supabase.instance.client;

  Future<List<ItemModel>> getItemsPerCategory(String categoryId,
      {int page = 1, int pageSize = 10}) async {
    final start = (page - 1) * pageSize;
    final end = start + pageSize - 1;

    final res = await supabase
        .from('items')
        .select()
        .eq('categoryId', categoryId)
        .range(start, end);

    final List<dynamic> data = res as List<dynamic>;
    final List<ItemModel> items =
        data.map((item) => ItemModel.fromJson(item)).toList();
    return items;
  }

  Future<List<ItemModel>> getItemsByName(String name) async {
    final res = await supabase.from('items').select().textSearch('name', name);
    final List<dynamic> data = res as List<dynamic>;
    final List<ItemModel> items =
        data.map((item) => ItemModel.fromJson(item)).toList();
    return items;
  }
}
