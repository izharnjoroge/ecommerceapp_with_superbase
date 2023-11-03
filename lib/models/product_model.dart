import 'package:flutter/material.dart';

class ProductModel {
  final String name;
  final String description;
  final String assetLocation;
  final String price;
  final Color color;

  ProductModel(
      {required this.name,
      required this.color,
      required this.price,
      required this.description,
      required this.assetLocation});
}
