import 'dart:developer';

import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/models/location_model.dart';
import 'package:ecommerceapp/models/order_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/repos/orderRepo/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final OrderRepo _orderRepo = OrderRepo();
  final supabase = Supabase.instance.client;

  _makeOrder(List<ItemModel> item) async {
    final user = supabase.auth.currentUser;
    final userMetadata = user?.userMetadata;

    final phone = userMetadata?['phone'] ?? '';
    final username = userMetadata?['username'] ?? '';
    final description = phone + username;
    final area = userMetadata?['area'] ?? '';
    final street = userMetadata?['street'] ?? '';

    LocationModel locationModel =
        LocationModel(area: area, street: street, description: description);

    OrderModelSent orderModel = OrderModelSent(
        items: item,
        amount: context.read<CartProvider>().getTotal().toString(),
        completed: false,
        details: locationModel,
        userId: user?.id ?? '');

    log('model;$orderModel');
    try {
      await _orderRepo.sendOrder(orderModel);

      if (mounted) {
        context.read<CartProvider>().clearCart();
      }

      Get.snackbar('Order made successfully', '',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 3));
    } catch (e) {
      log('error;$e');
      Get.snackbar('An error occurred', 'Please try again',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ItemModel> Item = context.watch<CartProvider>().itemData;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: size.height * .85,
                child: ListView.builder(
                    itemCount: Item.length,
                    padding: const EdgeInsets.all(5),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          leading: SizedBox(
                              height: 50,
                              width: 50,
                              child: SvgPicture.network(
                                Item[index].image,
                                fit: BoxFit.cover,
                              )),
                          title: Text(Item[index].name),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    Item[index].amount.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                context
                                    .read<CartProvider>()
                                    .removeFromCart(Item[index]);
                              },
                              icon: const Icon(Icons.delete)),
                        ),
                      );
                    }),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(10),
              height: size.height * .1,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Total: ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          const Text(
                            'KSH',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          Text(
                            ' ${context.read<CartProvider>().getTotal().toDouble().toString()}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _makeOrder(Item);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white,
                              width: 2,
                              style: BorderStyle.solid)),
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Text(
                            'Order Now',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
