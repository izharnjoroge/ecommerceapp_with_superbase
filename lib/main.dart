import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:ecommerceapp/blocs/orderBloc/order_bloc_cubit.dart';
import 'package:ecommerceapp/repos/categoryRepo/category_repo.dart';
import 'package:ecommerceapp/repos/orderRepo/order_repo.dart';
import 'package:ecommerceapp/screens/auth/signIn.dart';
import 'package:ecommerceapp/screens/landing%20page/load_screen.dart';
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

bool _supabaseInitialized = false;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  // initSupaBase();
  runApp(const MyApp());
}

Future<void> initSupaBase() async {
  if (!_supabaseInitialized) {
    await Supabase.initialize(
      url: dotenv.get('PUBLIC_URL'),
      anonKey: dotenv.get('PUBLIC_KEY'),
    );
    _supabaseInitialized = true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<void>(
      future: initSupaBase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Failed to initialize '),
              ),
            ),
          );
        }
        final supabase = Supabase.instance.client;
        final Session? session = supabase.auth.currentSession;

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
            child: GetMaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'E-Commerce App',
              home: FlutterSplashScreen(
                // useImmersiveMode: true,
                duration: const Duration(seconds: 2),
                nextScreen: session != null
                    ? session.isExpired
                        ? const LoginScreen()
                        : const LandingPage()
                    : const LoginScreen(),
                backgroundColor: Colors.white,
                splashScreenBody: Center(
                  child: Image.asset("assets/images/splash.png"),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
