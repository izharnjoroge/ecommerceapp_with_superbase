import 'package:supabase_flutter/supabase_flutter.dart';

class ItemsRepo {
  final supabase = Supabase.instance.client;
  Future getItemsPerCategory(String categoryId) async {
    final res =
        await supabase.from('categories').select().eq('categoryId', categoryId);

    return res;
  }
}
