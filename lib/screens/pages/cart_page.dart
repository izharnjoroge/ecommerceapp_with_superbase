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

import '../../functions/utils.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final OrderRepo _orderRepo = OrderRepo();
  final supabase = Supabase.instance.client;
  final UtilitiesFunctions utilitiesFunctions = UtilitiesFunctions();

  _makeOrder(List<ItemModel> item) async {
    final user = supabase.auth.currentUser;
    final userMetadata = user?.userMetadata;

    final phone = userMetadata?['phone'] ?? '';
    final username = userMetadata?['username'] ?? '';
    final description = phone + username;
    final area = userMetadata?['area'] ?? '';
    final street = userMetadata?['street'] ?? '';

    log('location;$description');

    LocationModel locationModel =
        LocationModel(area: area, street: street, description: description);

    OrderModelSent orderModel = OrderModelSent(
        items: item,
        amount: context.read<CartProvider>().getTotal(),
        completed: false,
        details: locationModel,
        userId: user?.id ?? '');

    try {
      await _orderRepo.sendOrder(orderModel);

      if (mounted) {
        context.read<CartProvider>().clearCart();
      }

      Get.snackbar('Order made successfully', 'Delivery will be made shortly.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 5));
    } catch (e) {
      Get.snackbar('An error occurred', 'Check your connection and try again',
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
    String grandTotal = utilitiesFunctions.formatAmountWithSymbol(
        context.watch<CartProvider>().getTotal(), 'en_US');

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
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: SvgPicture.network(
                            Item[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          Item[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Item[index].amount.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Qty: ${Item[index].quantity ?? '1'}',
                                style: const TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            context
                                .read<CartProvider>()
                                .removeFromCart(Item[index]);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: size.height * .12,
              width: size.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'KSH',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            grandTotal,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Item.length.isGreaterThan(0) ? _makeOrder(Item) : () {};
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: const Row(
                        children: [
                          Text(
                            'Order Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
