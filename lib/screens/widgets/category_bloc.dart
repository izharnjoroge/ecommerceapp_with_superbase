import 'dart:developer';

import 'package:ecommerceapp/blocs/categoryBloc/category_cubit.dart';
import 'package:ecommerceapp/blocs/itemsBloc/items_cubit.dart';
import 'package:ecommerceapp/repos/categoryRepo/category_repo.dart';
import 'package:ecommerceapp/repos/itemsRepo/items_repo.dart';
import 'package:ecommerceapp/screens/widgets/items_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit(CategoryRepo()),
        ),
        BlocProvider(
          create: (context) => ItemsCubit(ItemsRepo()),
        ),
      ],
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
  String selectedID = '';

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    log('here; $selectedID');

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
                  onTap: (value) {
                    setState(() {
                      selectedID = state.categoryModel[value].category_id;
                    });
                  },
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TabBarView(
                      children: state.categoryModel.map((category) {
                        return ItemsBloc(
                          categoryId: selectedID == ''
                              ? state.categoryModel[0].category_id
                              : selectedID,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is CategoryError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: Text('error fetching data'),
          );
        }
      },
    );
  }
}
