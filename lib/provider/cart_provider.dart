import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _productModel = [];

  get productData => _productModel;

  void addToCart(ProductModel product) {
    // Check if the product is already in the cart
    int existingIndex = _productModel.indexWhere((p) => p.name == product.name);

    if (existingIndex != -1) {
      _productModel[existingIndex].quantity += product.quantity!;
    } else {
      _productModel.add(product);
    }

    notifyListeners();
  }

  void decreaseItemCart(ProductModel product) {
    // Check if the product is already in the cart
    int existingIndex = _productModel.indexWhere((p) => p.name == product.name);

    if (existingIndex != -1) {
      _productModel[existingIndex].quantity - product.quantity;
    } else {
      _productModel.remove(product);
    }

    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _productModel.remove(product);
    notifyListeners();
  }

  double getTotal() {
    double total = 0.0;

    for (int i = 0; i < _productModel.length; i++) {
      total += _productModel[i].price * _productModel[i].quantity!;
    }

    return total;
  }
}
