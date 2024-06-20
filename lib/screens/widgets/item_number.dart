import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ItemCount extends StatefulWidget {
  final ItemModel productModel;
  final int itemCount;
  final ValueChanged<int> onItemCountChanged;

  const ItemCount({
    super.key,
    required this.productModel,
    required this.itemCount,
    required this.onItemCountChanged,
  });

  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  late int currentCount;

  @override
  void initState() {
    super.initState();
    currentCount = widget.itemCount;
  }

  @override
  void didUpdateWidget(ItemCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      setState(() {
        currentCount = widget.itemCount;
      });
    }
  }

  void _updateItemCount(int newCount) {
    setState(() {
      currentCount = newCount;
    });
    widget.onItemCountChanged(newCount);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            if (currentCount > 1) {
              _updateItemCount(currentCount - 1);
              context
                  .read<CartProvider>()
                  .decreaseItemCart(widget.productModel);
            }
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.remove,
              size: 30,
              color: Colors.purple,
            ),
          ),
        ),
        const Gap(20),
        Text(
          '$currentCount',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const Gap(20),
        GestureDetector(
          onTap: () {
            _updateItemCount(currentCount + 1);
            context.read<CartProvider>().increaseItemCart(widget.productModel);
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}
