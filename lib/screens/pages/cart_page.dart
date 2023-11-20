import 'package:ecommerceapp/models/product_model.dart';
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
    Size size = MediaQuery.of(context).size;
    List<ProductModel> product = context.watch<CartProvider>().productData;
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
                    itemCount: product.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  product[index].assetLocation,
                                  fit: BoxFit.cover,
                                )),
                            title: Text(product[index].name),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    //     SvgPicture.asset(
                                    //       'assets/dollar.svg',
                                    //       colorFilter: const ColorFilter.mode(
                                    //           Colors.black, BlendMode.srcIn),
                                    //       height: 20,
                                    //     ),
                                    Text(
                                      product[index].price.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                ItemCount(
                                  productModel: product[index],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  context
                                      .read<CartProvider>()
                                      .removeFromCart(product[index]);
                                },
                                icon: const Icon(Icons.delete)),
                          ),
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
                color: Colors.greenAccent,
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
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/dollar.svg',
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                            height: 20,
                          ),
                          const Gap(10),
                          Text(
                            ' ${context.read<CartProvider>().getTotal().toString()}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
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
                          'Pay Now',
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
      //             itemCount: value.productData.length,
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
