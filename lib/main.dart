import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/landing%20page/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void main() {
  runApp(const MyApp());
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
          title: 'Grocery App',
          home: FlutterSplashScreen(
              useImmersiveMode: true,
              duration: const Duration(seconds: 5),
              nextScreen: const LandingPage(),
              backgroundColor: Colors.white,
              splashScreenBody: Stack(
                children: [
                  Image.asset(
                    "assets/splash.jpeg",
                  ),
                  // Center(
                  //   child: const Text(
                  //     'Fat and Fresh Produce At Your Door Step',
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                ],
              ))),
    );
  }
}