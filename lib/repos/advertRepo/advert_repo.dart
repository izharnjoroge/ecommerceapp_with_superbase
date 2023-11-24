import 'package:supabase_flutter/supabase_flutter.dart';

class CarouselRepository {
  final supabase = Supabase.instance.client;

  Future getCarousels() async {
    final res = await supabase.from('carousels').select();
    print(res);
    return res;
  }
}
