import 'package:ecommerceapp/models/item_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<ItemModel> _ItemModel = [];

  get itemData => _ItemModel;

  void addToCart(ItemModel item) {
    if (!_ItemModel.contains(item)) {
      _ItemModel.add(item);
      notifyListeners();
    }
  }

  // void increaseItemCart(ItemModel item) {
  //   // Check if the item is already in the cart
  //   int existingIndex = _ItemModel.indexWhere((p) => p.name == item.name);
  //   if (existingIndex != -1) {
  //     _ItemModel[existingIndex].quantity += item.quantity;
  //     notifyListeners();
  //   }
  // }

  void removeFromCart(ItemModel item) {
    _ItemModel.remove(item);
    notifyListeners();
  }

  int getItems() {
    return _ItemModel.length;
  }

  double getTotal() {
    double total = 0.0;

    // Iterate over each item in the cart and sum up their prices
    for (var item in _ItemModel) {
      // Parse the amount string to extract the numeric value
      double price =
          double.tryParse(item.amount.replaceAll('KSH', '').trim()) ?? 0.0;
      total += price;
    }

    return total;
  }
}
