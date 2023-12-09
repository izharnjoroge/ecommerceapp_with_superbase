import 'package:ecommerceapp/blocs/itemsBloc/items_cubit.dart';
import 'package:ecommerceapp/repos/itemsRepo/items_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsBloc extends StatefulWidget {
  final String categoryId;
  const ItemsBloc({super.key, required this.categoryId});

  @override
  State<ItemsBloc> createState() => _ItemsBlocState();
}

class _ItemsBlocState extends State<ItemsBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ItemsCubit(ItemsRepo()),
        child: ItemContent(
          categoryId: widget.categoryId,
        ));
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
    context.read<ItemsCubit>().getItemsByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        } else if (state is ItemsLoaded) {
          return GridView.builder(
            itemCount: state.itemModel.length,
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 250,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text({state.itemModel.length} as String),
                ),
              );
            },
          );
        } else if (state is ItemsError) {
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
