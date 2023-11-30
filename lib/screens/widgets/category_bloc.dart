import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/blocs/categoryBloc/category_cubit.dart';
import 'package:ecommerceapp/repos/categoryRepo/category_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CategoryBLoc extends StatefulWidget {
  const CategoryBLoc({super.key});

  @override
  State<CategoryBLoc> createState() => _CategoryBLocState();
}

class _CategoryBLocState extends State<CategoryBLoc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(CategoryRepo()),
      child: const CategoryContent(),
    );
  }
}

class CategoryContent extends StatefulWidget {
  const CategoryContent({super.key});

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        } else if (state is CategoryLoaded) {
          return DefaultTabController(
            length: state.categoryModel.length,
            child: Column(
              children: [
                TabBar(
                  dividerColor: const Color.fromARGB(221, 29, 29, 29),
                  labelColor: Colors.purple,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.purple,
                  isScrollable: true,
                  tabs: state.categoryModel.map((category) {
                    return Tab(
                      child: Row(
                        children: [
                          SvgPicture.network(
                            category.url,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(category.name),
                        ],
                      ),
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
          );
        } else if (state is CategoryError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: Text('error'),
          );
        }
      },
    );
  }
}
