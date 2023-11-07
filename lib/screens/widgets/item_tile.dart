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
    return Container(
      decoration: BoxDecoration(
        color: widget.productModel.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: [
        SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              widget.productModel.assetLocation,
              fit: BoxFit.cover,
            )),
        const Gap(10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.productModel.name,
                style: TextStyle(
                  color: widget.productModel.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.productModel.description,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(widget.productModel.color)),
              onPressed: () {
                context.read<CartProvider>().addToCart(widget.productModel);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/dollar.svg',
                    color: Colors.black,
                    height: 20,
                  ),
                  Text(
                    widget.productModel.price,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Row(
                    children: [
                      Text(
                        'Add To cart',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
        )
      ]),
    );
  }
}
