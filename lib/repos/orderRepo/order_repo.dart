import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepo {
  final supabase = Supabase.instance.client;

  Future getOrders() async {
    final User? user = supabase.auth.currentUser;
    final res = await supabase.from('orders').select().eq('user_id', user!.id);
    return res;
  }
}
