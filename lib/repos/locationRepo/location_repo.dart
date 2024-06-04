import 'package:ecommerceapp/models/location_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocationRepo {
  final supabase = Supabase.instance.client;

  Future getLocations() async {
    final res = await supabase.from('location').select();

    final List<dynamic> data = res as List<dynamic>;
    final List<ListLocationModel> items =
        data.map((item) => ListLocationModel.fromJson(item)).toList();
    return items;
  }
}
