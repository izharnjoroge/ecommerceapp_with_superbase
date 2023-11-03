import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../widgets/item_tile.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> list = [
      ProductModel(
          name: 'Strawberries',
          color: Colors.red,
          price: '2.30',
          description: 'Juicy Strawberries',
          assetLocation: 'assets/strawberries.jpg'),
      ProductModel(
          name: 'Apples',
          color: Colors.green,
          price: '1.47',
          description: 'Fresh Apples',
          assetLocation: 'assets/apple.jpg'),
      ProductModel(
          name: 'Basket',
          color: Colors.yellow,
          price: '5.30',
          description: 'Our pick for the best fruits',
          assetLocation: 'assets/basket.jpg'),
      ProductModel(
          name: 'Favourite',
          color: Colors.purpleAccent,
          price: '5.20',
          description: 'Voted as everyones\n favourite pick',
          assetLocation: 'assets/composition.jpg')
    ];
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                const Row(
                  children: [
                    Text('Welcome',
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ],
                ),
                const Gap(30),
                const Text(
                  'Get Fresh Products, right to your doorstep',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                const Gap(30),
                SizedBox(
                  height: size.height,
                  child: GridView.builder(
                      itemCount: list.length,
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 300,
                              crossAxisCount: 2),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: ItemTile(
                            productModel: list[index],
                          ),
                        );
                      })),
                ),
              ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => const CartPage());
            },
            child: SvgPicture.asset(
              'assets/cart_fast.svg',
              color: Colors.yellowAccent,
            ),
          )),
    );
  }
}
