import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatelessWidget {
  final ItemModel itemModel;
  const ItemDetails({super.key, required this.itemModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Description',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Get.back()),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                    height: size.height * 0.6,
                    width: size.width,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12)),
                    child: SvgPicture.network(itemModel.image)),
                Column(
                  children: [
                    Text(
                      itemModel.name,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      itemModel.description,
                      softWrap: true,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/dollar.svg',
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                            height: 20,
                          ),
                          Text(
                            itemModel.amount,
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {
                            context.read<CartProvider>().addToCart(itemModel);
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Add To cart',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            Get.to(() => const CartPage());
          },
          child: SvgPicture.asset(
            'assets/svg/cart_fast.svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ));
  }
}
