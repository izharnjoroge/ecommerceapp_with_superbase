import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/category_model.dart';
import 'package:ecommerceapp/blocs/categoryBloc/category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../provider/categoryId_provider.dart';
import 'items_bloc.dart';

class CategoryContent extends StatefulWidget {
  const CategoryContent({super.key});

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isTabControllerInitialized = false;
  bool _isSelectedIdSet = false; // Track if the selected ID has been set.

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
    _tabController.addListener(() {
      final selectedID = categories[_tabController.index].category_id;
      context.read<SelectedCategoryProvider>().setSelectedID(selectedID);
    });
    _isTabControllerInitialized = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = context.read<SelectedCategoryProvider>();
    final cubitState = context.read<CategoryCubit>().state;

    if (!_isSelectedIdSet && cubitState is CategoryLoaded) {
      provider.setSelectedID(cubitState.categoryModel[0].category_id);
      _isSelectedIdSet = true;
    }
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
          if (!_isTabControllerInitialized) {
            _initializeTabController(state.categoryModel);
          }

          final initialId = state.categoryModel[0].category_id;

          return DefaultTabController(
            length: state.categoryModel.length,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.purple,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.purple,
                  isScrollable: true,
                  onTap: (index) {
                    final selectedID = state.categoryModel[index].category_id;
                    context
                        .read<SelectedCategoryProvider>()
                        .setSelectedID(selectedID);
                  },
                  tabs: state.categoryModel.map((category) {
                    return Tab(
                      child: Row(
                        children: [
                          SvgPicture.network(
                            category.url,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(category.name),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: TabBarView(
                        key: ValueKey<int>(_tabController.index),
                        controller: _tabController,
                        children: state.categoryModel.map((category) {
                          return ItemsBloc(categoryId: initialId);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is CategoryError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Failed to load categories. Please try again.',
                  style: TextStyle(color: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CategoryCubit>().getCategories();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Unknown error occurred.'),
          );
        }
      },
    );
  }
}
