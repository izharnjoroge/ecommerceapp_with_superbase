// ignore: file_names
import 'package:ecommerceapp/screens/widgets/SearchWidget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Gap(20),
            SearchWidget(),
          ],
        ),
      ),
    );
  }
}
