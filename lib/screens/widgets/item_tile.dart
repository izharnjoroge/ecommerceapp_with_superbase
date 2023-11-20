import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatefulWidget {
  final ProductModel productModel;
  const ItemTile({super.key, required this.productModel});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(
            widget.productModel.assetLocation,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: IconButton(
            icon: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.grey,
            ),
            onPressed: () {
              // Add your favorite button logic here
            },
          ),
        )
      ]),
      const Gap(10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.productModel.name,
                  style: TextStyle(
                    color: widget.productModel.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'KSH:  ' '${widget.productModel.price.toString()}',
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                GestureDetector(
                  onTap: () {
                    context.read<CartProvider>().addToCart(widget.productModel);
                  },
                  child: SvgPicture.asset(
                    'assets/cart_fast.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.purple, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
