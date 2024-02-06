import 'package:ecommerceapp/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepo {
  final supabase = Supabase.instance.client;
  Future getCategories() async {
    final res = await supabase.from('categories').select();
    final List<dynamic> data = res as List<dynamic>;
    final List<CategoryModel> categories =
        data.map((item) => CategoryModel.fromJson(item)).toList();
    return categories;
  }
}
