import 'package:ecommerceapp/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemsRepo {
  final supabase = Supabase.instance.client;
  Future getItemsPerCategory(String categoryId) async {
    final res =
        await supabase.from('items').select().eq('categoryId', categoryId);
    final List<dynamic> data = res as List<dynamic>;
    final List<ItemModel> items =
        data.map((item) => ItemModel.fromJson(item)).toList();
    // var List<ItemModel> testData = items.where((element) => element.categoryId == categoryId);

    return items;
  }
}
