import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/widgets/item_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
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
                    onTap: () {},
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
      // body: Consumer<CartProvider>(
      //   builder: (context, value, child) {
      //     return Column(
      //       children: [
      //         ListView.builder(
      //             itemCount: value.ItemData.length,
      //             padding: EdgeInsets.all(12),
      //             itemBuilder: (context, index) {
      //               return Padding(
      //                 padding: const EdgeInsets.all(10.0),
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                     color: Colors.grey[200],
      //                     borderRadius: BorderRadius.circular(15)
      //                   ),
      //                   child: ListTile(
      //                        leading: Image.asset(value.productData[index].),
      //                   ),
      //                 ),
      //               )
      //             })
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
