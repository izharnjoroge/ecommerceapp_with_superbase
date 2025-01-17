import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/pages/cart_page.dart';
import 'package:ecommerceapp/screens/pages/drawer_page.dart';
import 'package:ecommerceapp/screens/widgets/banner_bloc.dart';
import 'package:ecommerceapp/screens/widgets/category_bloc.dart';
import 'package:ecommerceapp/screens/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<ItemModel> Item = context.watch<CartProvider>().itemData;

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
          drawer: const DrawerPage(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: size.height * .30,
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
                    height: size.height * .6, child: const CategoryContent()),
                const SizedBox(height: 10),
              ]),
            ),
          ),
          floatingActionButton: badges.Badge(
            badgeContent: Text(
              ' ${Item.length.toString()}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            position: badges.BadgePosition.topEnd(top: -10, end: -12),
            badgeAnimation: const badges.BadgeAnimation.slide(
              loopAnimation: false,
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
            showBadge: true,
            child: FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () {
                Get.to(() => const CartPage());
              },
              child: SvgPicture.asset(
                'assets/svg/cart_fast.svg',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          )),
    );
  }
}
