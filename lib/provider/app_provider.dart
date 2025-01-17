import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../blocs/categoryBloc/category_cubit.dart';
import '../blocs/itemsBloc/items_cubit.dart';
import '../blocs/orderBloc/order_bloc_cubit.dart';
import '../provider/cart_provider.dart';
import '../repos/categoryRepo/category_repo.dart';
import '../repos/itemsRepo/items_repo.dart';
import '../repos/orderRepo/order_repo.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

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
        BlocProvider(
          create: (context) => OrderCubit(OrderRepo()),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartProvider()),
        ],
        child: child,
      ),
    );
  }
}
