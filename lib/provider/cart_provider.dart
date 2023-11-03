import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _productModel = [];

  get productData => _productModel;

  void addToCart(ProductModel product) {
    _productModel.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _productModel.remove(product);
    notifyListeners();
  }

  String getTotal() {
    double total = 0.0;
    for (int i = 0; i < _productModel.length; i++) {
      total += double.parse(_productModel[i].price);
    }
    return total.toString();
  }
}
