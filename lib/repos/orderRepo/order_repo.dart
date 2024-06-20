import 'package:ecommerceapp/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepo {
  final supabase = Supabase.instance.client;

  Future getOrders() async {
    final User? user = supabase.auth.currentUser;

    // Handle the case where the user might be null
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final res = await supabase.from('orders').select().eq('user_id', user.id);
    final List<dynamic> data = res as List<dynamic>;
    final List<OrderModel> items =
        data.map((item) => OrderModel.fromJson(item)).toList();
    return items;
  }

  Future sendOrder(OrderModelSent order) async {
    final res = await supabase.from('orders').insert(order.toJson());
    return res;
  }
}
