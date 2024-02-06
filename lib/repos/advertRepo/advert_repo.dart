import 'package:ecommerceapp/models/carousel_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CarouselRepository {
  final supabase = Supabase.instance.client;

  Future<List<CarouselModel>> getCarousels() async {
    final res = await supabase.from('carousels').select();
    final List<dynamic> data = res as List<dynamic>;
    final List<CarouselModel> carousels =
        data.map((item) => CarouselModel.fromJson(item)).toList();

    return carousels;
  }
}
