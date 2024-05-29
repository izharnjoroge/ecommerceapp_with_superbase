// ignore: file_names
import 'package:ecommerceapp/blocs/itemsBloc/items_cubit.dart';
import 'package:ecommerceapp/screens/widgets/SearchWidget.dart';
import 'package:ecommerceapp/screens/widgets/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Gap(20),
            SearchWidget(),
            Gap(20),
            Expanded(
              child: BlocBuilder<ItemsCubit, ItemsState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.purple),
                    );
                  } else if (state is SearchLoaded) {
                    if (state.itemModel.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.itemModel.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.to(
                              () => ItemDetails(
                                  itemModel: state.itemModel[index]),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 236, 236, 236),
                                ),
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    SvgPicture.network(
                                      state.itemModel[index].image,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    ),
                                    const Gap(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('Nothing Here'));
                    }
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return const Center(
                      child: Text('Search for an item ....'),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
