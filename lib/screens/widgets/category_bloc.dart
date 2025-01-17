import 'package:ecommerceapp/blocs/categoryBloc/category_cubit.dart';
import 'package:ecommerceapp/models/category_model.dart';
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
    return const CategoryContent();
  }
}

class CategoryContent extends StatefulWidget {
  const CategoryContent({super.key});

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isTabControllerInitialized = false;
  String selectedID = '';

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  void dispose() {
    if (_isTabControllerInitialized) {
      _tabController.dispose();
    }
    super.dispose();
  }

  void _initializeTabController(List<CategoryModel> categories) {
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(() async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        selectedID = categories[_tabController.index].category_id;
      });
    });
    _isTabControllerInitialized = true;
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
          // Initialize the TabController if it's not already initialized
          if (!_isTabControllerInitialized) {
            _initializeTabController(state.categoryModel);
          }

          return DefaultTabController(
            length: state.categoryModel.length,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  onTap: (value) async {
                    await Future.delayed(const Duration(seconds: 1));
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
                      controller: _tabController,
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
          return const Center(
            child: Text('Please check your connection and try again.'),
          );
        } else {
          return const Center(
            child: Text('Error fetching data'),
          );
        }
      },
    );
  }
}
