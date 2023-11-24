import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCount extends StatefulWidget {
  final ProductModel productModel;
  const ItemCount({super.key, required this.productModel});

  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5)),
          child: GestureDetector(
            onTap: () {
              if (itemCount > 1) {
                setState(() {
                  itemCount--;
                });
                context.read<CartProvider>().decreaseItemCart(
                      ProductModel(
                        name: widget.productModel.name,
                        price: widget.productModel.price,
                        description: widget.productModel.description,
                        color: widget.productModel.color,
                        quantity: itemCount,
                        assetLocation: widget.productModel.assetLocation,
                      ),
                    );
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$itemCount",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5)),
          child: GestureDetector(
            onTap: () {
              setState(() {
                itemCount++;
              });
              context.read<CartProvider>().increaseItemCart(
                    ProductModel(
                      name: widget.productModel.name,
                      price: widget.productModel.price,
                      description: widget.productModel.description,
                      color: widget.productModel.color,
                      quantity: itemCount,
                      assetLocation: widget.productModel.assetLocation,
                    ),
                  );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
