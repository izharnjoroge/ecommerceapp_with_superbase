import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../blocs/itemsBloc/items_cubit.dart';
import '../../provider/categoryId_provider.dart';
import 'item_details.dart';

class ItemsBloc extends StatefulWidget {
  final String categoryId;
  const ItemsBloc({super.key, required this.categoryId});

  @override
  State<ItemsBloc> createState() => _ItemsBlocState();
}

class _ItemsBlocState extends State<ItemsBloc> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchItems();
    _scrollController.addListener(_onScroll);
  }

  void _fetchItems() {
    final selectedID = context.read<SelectedCategoryProvider>().selectedID;
    if (selectedID.isNotEmpty) {
      context.read<ItemsCubit>().getItemsByCategory(selectedID);
    } else {
      context.read<ItemsCubit>().getItemsByCategory(widget.categoryId);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchItems();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 200) {
      final selectedID = context.read<SelectedCategoryProvider>().selectedID;
      context.read<ItemsCubit>().loadMoreItems(selectedID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        } else if (state is ItemsLoaded || state is ItemsLoadedMore) {
          final items = state is ItemsLoaded
              ? state.itemModel
              : (state as ItemsLoadedMore).itemModelMore;
          final isLoadingMore = state is ItemsLoadedMore && state.isLoadingMore;

          if (items.isNotEmpty) {
            return Stack(
              children: [
                GridView.builder(
                  controller: _scrollController,
                  itemCount: items.length,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 250,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.to(
                        () => ItemDetails(itemModel: items[index]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 236, 236, 236),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.network(
                                    items[index].image,
                                    height: 150,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                              const Gap(10),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(items[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.purple,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start),
                                    Text(items[index].amount,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (isLoadingMore)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.purple),
                    ),
                  ),
              ],
            );
          } else {
            return const Center(child: Text('Nothing Here'));
          }
        } else if (state is ItemsError) {
          return const Center(
            child: Text('Please check your connection and try again.'),
          );
        } else {
          return const Center(
            child: Text('Nothing Here'),
          );
        }
      },
    );
  }
}
