import 'package:ecommerceapp/repos/categoryRepo/category_repo.dart';
import 'package:ecommerceapp/screens/landing%20page/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'blocs/categoryBloc/category_cubit.dart';
import 'blocs/itemsBloc/items_cubit.dart';
import 'repos/itemsRepo/items_repo.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  initSupaBase();
  runApp(const MyApp());
}

Future<void> initSupaBase() async {
  await Supabase.initialize(
    url: dotenv.get('PUBLIC_URL'),
    anonKey: dotenv.get('PUBLIC_KEY'),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ],
      child: ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: GetMaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce App',
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
