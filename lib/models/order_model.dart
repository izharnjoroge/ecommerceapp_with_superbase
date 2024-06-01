import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/models/location_model.dart';

class OrderModel {
  final String id;
  final DateTime created_at;
  final List<ItemModel> items;
  final int amount;
  final bool completed;
  final LocationModel details;

  OrderModel({
    required this.id,
    required this.created_at,
    required this.items,
    required this.amount,
    required this.completed,
    required this.details,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      items: (json['items'] as List<dynamic>)
          .map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      amount: json['amount'] as int,
      completed: json['completed'] as bool,
      details: LocationModel.fromJson(json['details'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'ItemModel(id: $id, items: $items, amount: $amount, details: $details,completed: $completed)';
  }
}
