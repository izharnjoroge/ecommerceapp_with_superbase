import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return TextField(
      controller: searchController,
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
          borderSide: const BorderSide(color: Colors.purple, width: 2),
        ),
      ),
    );
  }
}
