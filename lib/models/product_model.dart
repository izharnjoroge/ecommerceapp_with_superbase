import 'package:flutter/material.dart';

class ProductModel {
  final String name;
  final String description;
  final String assetLocation;
  final double price;
  final Color color;
  int quantity;

  ProductModel(
      {required this.name,
      required this.color,
      required this.price,
      required this.description,
      required this.assetLocation,
      this.quantity = 1});
}
