import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:ecommerceapp/screens/landing%20page/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: GetMaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce App',
          home: FlutterSplashScreen(
              useImmersiveMode: true,
              duration: const Duration(seconds: 5),
              nextScreen: const SplashScreen(),
              backgroundColor: Colors.white,
              splashScreenBody: Center(
                child: Lottie.asset(
                  "assets/lotties/splash.json",
                ),
              ))),
    );
  }
}
