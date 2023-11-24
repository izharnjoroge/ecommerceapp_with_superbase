import 'package:ecommerceapp/models/carousel_model.dart';
import 'package:ecommerceapp/models/category_model.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/pages/cart_page.dart';
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
  List<CategoryModel> categories = [
    CategoryModel(categoryName: 'Utilities'),
    CategoryModel(categoryName: 'Food'),
    CategoryModel(categoryName: 'Electronics'),
    CategoryModel(categoryName: 'Education'),
    CategoryModel(categoryName: 'Clothes'),
    CategoryModel(categoryName: 'Shoes'),
    CategoryModel(categoryName: 'Toys'),
    CategoryModel(categoryName: 'Kitchen Corner'),
  ];
  List<CarouselModel> carousels = [
    CarouselModel(
        url:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.mf66GxvX7K_m4A0S9R8atgHaD4%26pid%3DApi&f=1&ipt=308c0266ce137304dcb902367b613e63d0a859de9619aaadefa742e3c6bf8647&ipo=images'),
    CarouselModel(
        url:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.754PQJwYXoeXJT13IeSLIgHaEo%26pid%3DApi&f=1&ipt=0ed9734db4ea2eaef4e4687498514c9a332191189bc52c72d17992394c856a25&ipo=images'),
    CarouselModel(
        url:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.8QHQIPt3xKn-FDZtYmOEbQHaD5%26pid%3DApi&f=1&ipt=6fd879e7695bb3062ef563e49ecf0bb9f43391ebf336d5de0356eba57f013319&ipo=images'),
    CarouselModel(
        url:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.8Hl-IsGcQQUYw7ZZR-ikhAHaFR%26pid%3DApi&f=1&ipt=e93e18d5925a290fd8f4fded6bf5fabef61dca58bc221001854778583cf2a24a&ipo=images'),
  ];
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
          // appBar: AppBar(
          //   title: const Text('CHINA SQUARE',
          //       style: TextStyle(
          //           color: Colors.purple,
          //           fontWeight: FontWeight.w600,
          //           fontSize: 25)),
          //   centerTitle: true,
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   leading: IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.menu,
          //         color: Colors.purple,
          //       )),
          //   actions: [
          //     IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.person_2_outlined,
          //           color: Colors.purple,
          //         ))
          //   ],
          // ),
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
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: carousels.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        width: size.width * .85,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                                image: NetworkImage(carousels[index].url),
                                fit: BoxFit.cover)),
                      );
                    }),
              ),
              const Gap(10),
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
                  Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // SizedBox(
              //   height: size.height * .05,
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: categories.length,
              //       itemBuilder: (context, index) {
              //         return Container(
              //           margin: const EdgeInsets.all(10),
              //           width: size.width * .35,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(12),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.grey.withOpacity(0.5),
              //                 spreadRadius: 5,
              //                 blurRadius: 7,
              //                 offset: const Offset(0, 3),
              //               ),
              //             ],
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 categories[index].categoryName,
              //                 style: const TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         );
              //       }),
              // ),
              DefaultTabController(
                length: categories.length,
                child: Column(
                  children: [
                    TabBar(
                      dividerColor: const Color.fromARGB(221, 29, 29, 29),
                      labelColor: Colors.purple,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.purple,
                      isScrollable: true,
                      tabs: categories.map((category) {
                        return Tab(
                          text: category.categoryName,
                        );
                      }).toList(),
                    ),
                    // Expanded(
                    //   child: TabBarView(
                    //     children: categories.map((category) {
                    //       return Container(
                    //         margin: const EdgeInsets.all(10),
                    //         width: MediaQuery.of(context).size.width * 0.35,
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(12),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.5),
                    //               spreadRadius: 5,
                    //               blurRadius: 7,
                    //               offset: const Offset(0, 3),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Center(
                    //           child: Text(
                    //             category.categoryName,
                    //             style: const TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                  ],
                ),
              ),

              const Gap(10),
              Expanded(
                child: SizedBox(
                    height: size.height * .45,
                    child: GridView.builder(
                      itemCount: list.length,
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              mainAxisExtent: 250,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ItemTile(
                            productModel: list[index],
                          ),
                        );
                      },
                    )),
              ),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            onPressed: () {
              Get.to(() => const CartPage());
            },
            child: SvgPicture.asset(
              'assets/cart_fast.svg',
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          )),
    );
  }
}
