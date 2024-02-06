import 'dart:ui';

import 'package:ecommerceapp/screens/auth/signIn.dart';
import 'package:ecommerceapp/screens/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: const SplashAppBar(),
        body: Column(
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () => Get.off(() => const LoginScreen()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * .05,
                    width: size.width * .5,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.pink, Colors.purple]),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple),
                    child: const Center(
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
