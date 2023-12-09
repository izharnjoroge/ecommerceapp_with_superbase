import 'package:ecommerceapp/models/carousel_model.dart';
import 'package:ecommerceapp/models/category_model.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/pages/cart_page.dart';
import 'package:ecommerceapp/screens/widgets/banner_bloc.dart';
import 'package:ecommerceapp/screens/widgets/category_bloc.dart';
import 'package:ecommerceapp/screens/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../widgets/item_tile.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> list = [
    ProductModel(
        name: 'Strawberries',
        color: Colors.red,
        price: 2.30,
        description: 'Juicy Strawberries',
        assetLocation: 'assets/strawberries.jpg'),
    ProductModel(
        name: 'Apples',
        color: Colors.green,
        price: 1.47,
        description: 'Fresh Apples',
        assetLocation: 'assets/apple.jpg'),
    ProductModel(
        name: 'Basket',
        color: Colors.orange,
        price: 5.30,
        description: 'Our pick.',
        assetLocation: 'assets/basket.jpg'),
    ProductModel(
        name: 'Favourite',
        color: Colors.purpleAccent,
        price: 5.20,
        description: 'Voted by everyone.',
        assetLocation: 'assets/composition.jpg'),
    ProductModel(
        name: 'Favourite',
        color: Colors.purpleAccent,
        price: 5.20,
        description: 'Voted by everyone.',
        assetLocation: 'assets/composition.jpg')
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              TextField(
                controller: _searchController,
                cursorColor: Colors.purple,
                decoration: InputDecoration(
                  focusColor: Colors.purple,
                  prefixIcon: const Icon(Icons.search, color: Colors.purple),
                  suffixIcon: const Icon(Icons.sort, color: Colors.purple),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.purple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 2),
                  ),
                ),
              ),
              const Gap(10),
              SizedBox(
                height: size.height * .25,
                child: const CarouselBLoc(),
              ),
              const Gap(20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .65,
                child: const CategoryBLoc(),
              ),
              const Gap(10),
              // Expanded(
              //   child: SizedBox(
              //       height: size.height * .45,
              //       child: GridView.builder(
              //         itemCount: list.length,
              //         padding: const EdgeInsets.all(12),
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //                 crossAxisSpacing: 5,
              //                 mainAxisSpacing: 5,
              //                 mainAxisExtent: 250,
              //                 crossAxisCount: 2),
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.only(bottom: 10.0),
              //             child: ItemTile(
              //               productModel: list[index],
              //             ),
              //           );
              //         },
              //       )),
              // ),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            onPressed: () {
              Get.to(() => const CartPage());
            },
            child: SvgPicture.asset(
              'assets/svg/cart_fast.svg',
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          )),
    );
  }
}
