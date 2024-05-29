import 'dart:async';
import 'package:ecommerceapp/blocs/itemsBloc/items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Make sure to import the necessary packages for your Bloc/Cubit

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 5), () {
      context.read<ItemsCubit>().searchItems(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      cursorColor: Colors.purple,
      onChanged: (text) => _onSearchChanged(),
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
          borderSide: const BorderSide(color: Colors.purple, width: 2),
        ),
      ),
    );
  }
}
