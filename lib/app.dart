import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/navigation_service.dart';
import 'config/supabase_initializer.dart';
import 'provider/app_provider.dart';
import 'screens/auth/signIn.dart';
import 'screens/landing page/load_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Text('Failed to initialize'),
              ),
            ),
          );
        }
        final supabase = Supabase.instance.client;
        final session = supabase.auth.currentSession;

        return AppProviders(
          child: GetMaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Astroune E-Commerce',
            home: FlutterSplashScreen(
              duration: const Duration(seconds: 2),
              nextScreen: session != null
                  ? session.isExpired
                      ? const LoginScreen()
                      : const LandingPage()
                  : const LoginScreen(),
              backgroundColor: Colors.black,
              splashScreenBody: Center(
                child: Image.asset("assets/images/transparent-logo.png"),
              ),
            ),
          ),
        );
      },
    );
  }
}
