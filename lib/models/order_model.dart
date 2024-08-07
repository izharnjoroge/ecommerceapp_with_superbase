import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/models/location_model.dart';

class OrderModel {
  final String id;
  final DateTime created_at;
  final List<OrderItemModel> items;
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
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
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

class OrderModelSent {
  final List<ItemModel> items;
  final double amount;
  final bool completed;
  final LocationModel details;
  final String userId;

  OrderModelSent(
      {required this.items,
      required this.amount,
      required this.completed,
      required this.details,
      required this.userId});

  Map<String, dynamic> toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        'amount': amount,
        'completed': completed,
        'details': details.toJson(),
        'user_id': userId
      };

  @override
  String toString() {
    return ' items: $items, amount: $amount, details: $details,completed: $completed,id:$userId)';
  }
}
