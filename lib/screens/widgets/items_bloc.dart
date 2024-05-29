import 'dart:developer';

import 'package:ecommerceapp/blocs/itemsBloc/items_cubit.dart';
import 'package:ecommerceapp/screens/widgets/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ItemsBloc extends StatefulWidget {
  final String categoryId;
  const ItemsBloc({super.key, required this.categoryId});

  @override
  State<ItemsBloc> createState() => _ItemsBlocState();
}

class _ItemsBlocState extends State<ItemsBloc> {
  @override
  Widget build(BuildContext context) {
    return ItemContent(
      categoryId: widget.categoryId,
    );
  }
}

class ItemContent extends StatefulWidget {
  final String categoryId;
  const ItemContent({super.key, required this.categoryId});

  @override
  State<ItemContent> createState() => _ItemContentState();
}

class _ItemContentState extends State<ItemContent> {
  @override
  void initState() {
    super.initState();
    ;
    log('initState; ${widget.categoryId}');
    context.read<ItemsCubit>().getItemsByCategory(widget.categoryId);
  }

  @override
  void didUpdateWidget(covariant ItemContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      log('didUpdateWidget; ${widget.categoryId}');
      context.read<ItemsCubit>().getItemsByCategory(widget.categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    log('build; ${widget.categoryId}');

    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        } else if (state is ItemsLoaded) {
          if (state.itemModel.length > 0) {
            return GridView.builder(
              itemCount: state.itemModel.length,
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
                    () => ItemDetails(itemModel: state.itemModel[index]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 236, 236, 236),
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
                                state.itemModel[index].image,
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
                                Text(state.itemModel[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.purple,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start),
                                Text(state.itemModel[index].amount,
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
            );
          } else {
            return Center(child: Text('Nothing Here'));
          }
        } else if (state is ItemsError) {
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
