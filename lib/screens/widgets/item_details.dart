import 'package:ecommerceapp/models/item_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/pages/cart_page.dart';
import 'package:ecommerceapp/screens/widgets/item_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ItemDetails extends StatefulWidget {
  final ItemModel itemModel;
  const ItemDetails({super.key, required this.itemModel});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<ItemModel> items = context.watch<CartProvider>().itemData;
    bool isInCart =
        items.any((item) => item.item_id == widget.itemModel.item_id);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Description',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        //   onPressed: () => Get.back(),
        // ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.4,
                    width: size.width - 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.network(widget.itemModel.image),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemModel.name,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            widget.itemModel.description,
                            softWrap: true,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Container(
                width: size.width - 50,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quantity',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const Gap(10),
                            ItemCount(
                              itemCount: itemCount,
                              productModel: widget.itemModel,
                              onItemCountChanged: (newCount) {
                                setState(() {
                                  itemCount = newCount;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.itemModel.amount,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              if (isInCart) {
                                setState(() {
                                  itemCount = 1;
                                });
                                context
                                    .read<CartProvider>()
                                    .removeFromCart(widget.itemModel);
                              } else {
                                context
                                    .read<CartProvider>()
                                    .addToCart(widget.itemModel);
                              }
                            },
                            child: Text(
                              isInCart ? 'Remove From Cart' : 'Add To Cart',
                              style: TextStyle(
                                color: isInCart ? Colors.red : Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: badges.Badge(
        badgeContent: Text(
          ' ${items.length.toString()}',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
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
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              clipBehavior: Clip.antiAlias,
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              builder: (BuildContext context) {
                return Container(
                  color: Colors.black,
                  child: const FractionallySizedBox(
                    heightFactor: 0.7,
                    child: CartPage(),
                  ),
                );
              },
            );
          },
          child: SvgPicture.asset(
            'assets/svg/cart_fast.svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
