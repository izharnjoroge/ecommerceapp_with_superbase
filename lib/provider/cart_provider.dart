import 'package:ecommerceapp/functions/utils.dart';
import 'package:ecommerceapp/models/item_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<ItemModel> _ItemModel = [];
  final UtilitiesFunctions utilitiesFunctions = UtilitiesFunctions();

  List<ItemModel> get itemData => _ItemModel;

  void addToCart(ItemModel item, int quantity) {
    int existingIndex = _ItemModel.indexWhere((p) => p.item_id == item.item_id);
    if (existingIndex == -1) {
      item.quantity = quantity;
      item.newAmount = getNewAmount(item.amount, quantity);
      _ItemModel.add(item);
    }
    notifyListeners();
  }

  void increaseItemCart(ItemModel item) {
    int existingIndex = _ItemModel.indexWhere((p) => p.item_id == item.item_id);
    if (existingIndex != -1) {
      _ItemModel[existingIndex].quantity =
          (_ItemModel[existingIndex].quantity ?? 1) + 1;
      _ItemModel[existingIndex].newAmount = getNewAmount(
          _ItemModel[existingIndex].amount,
          _ItemModel[existingIndex].quantity ?? 1);
    } else {
      item.quantity = 2;
      item.newAmount = getNewAmount(item.amount, 2);
      _ItemModel.add(item);
    }
    notifyListeners();
  }

  void decreaseItemCart(ItemModel item) {
    int existingIndex = _ItemModel.indexWhere((p) => p.item_id == item.item_id);
    if (existingIndex != -1 && (_ItemModel[existingIndex].quantity ?? 1) > 1) {
      _ItemModel[existingIndex].quantity =
          (_ItemModel[existingIndex].quantity ?? 1) - 1;
      notifyListeners();
    }
    notifyListeners();
  }

  void removeFromCart(ItemModel item) {
    _ItemModel.removeWhere((p) => p.item_id == item.item_id);
    notifyListeners();
  }

  void clearCart() {
    _ItemModel.clear();
    notifyListeners();
  }

  int getItems() {
    return _ItemModel.length;
  }

  double getTotal() {
    double total = 0.0;

    for (var item in _ItemModel) {
      double price = double.tryParse(
              item.amount.replaceAll('KSH', '').replaceAll(',', '').trim()) ??
          0.0;

      total += price * (item.quantity ?? 1);
    }

    return total;
  }

  double getNewAmount(String amount, int quantity) {
    double total = 0.0;

    double price = double.tryParse(
            amount.replaceAll('KSH', '').replaceAll(',', '').trim()) ??
        0.0;

    total += price * (quantity);

    return total;
  }
}
