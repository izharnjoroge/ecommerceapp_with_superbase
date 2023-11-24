import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepo {
  final supabase = Supabase.instance.client;

  Future getCategories() async {
    final res = await supabase.from('categories').select();
    print(res);
    return res;
  }

  Future getItemsPerCategory(String categoryName) async {
    final res = await supabase
        .from('categories')
        .select()
        .eq('categoryName', categoryName);
    print(res);
    return res;
  }
}
