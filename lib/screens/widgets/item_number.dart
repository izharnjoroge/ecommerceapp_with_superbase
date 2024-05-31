import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ItemCount extends StatefulWidget {
  final ItemModel productModel;
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
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5)),
          child: GestureDetector(
            onTap: () {
              if (itemCount > 1) {
                setState(() {
                  itemCount--;
                  context.read<CartProvider>().decreaseItemCart(ItemModel(
                      item_id: widget.productModel.item_id,
                      created_at: widget.productModel.created_at,
                      name: widget.productModel.name,
                      description: widget.productModel.description,
                      image: widget.productModel.image,
                      amount: widget.productModel.amount,
                      rating: widget.productModel.rating,
                      categoryId: widget.productModel.categoryId,
                      quantity: itemCount));
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove,
                    size: 30,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(20),
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ],
          ),
        ),
        const Gap(20),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5)),
          child: GestureDetector(
            onTap: () {
              setState(() {
                itemCount++;
                context.read<CartProvider>().increaseItemCart(ItemModel(
                    item_id: widget.productModel.item_id,
                    created_at: widget.productModel.created_at,
                    name: widget.productModel.name,
                    description: widget.productModel.description,
                    image: widget.productModel.image,
                    amount: widget.productModel.amount,
                    rating: widget.productModel.rating,
                    categoryId: widget.productModel.categoryId,
                    quantity: itemCount));
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
