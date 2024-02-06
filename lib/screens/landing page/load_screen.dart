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

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(children: [
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
                    height: size.height * .65, child: const CategoryBLoc()),
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
