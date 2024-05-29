import 'package:ecommerceapp/screens/pages/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomAppBar({super.key, required this.scaffoldKey});

  @override
  Size get preferredSize => const Size.fromHeight(90.0);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarClipper(),
      child: AppBar(
        title: const Text(
          'E-Commerce',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.purple,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const SearchPage()),
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = size.height / 1.7;
    var p = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(0, curveHeight, curveHeight, curveHeight)
      ..lineTo(size.width - curveHeight, curveHeight)
      ..quadraticBezierTo(size.width, curveHeight, size.width, size.height)
      ..lineTo(size.width, 0);

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SplashAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SplashAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(500.0);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Customshape(),
      child: AppBar(
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: SizedBox(
            height: 490,
            // child: Lottie.asset(
            // "assets/lotties/robot.json",
            //),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class Customshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = size.height / 1.4;
    var p = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(0, curveHeight, curveHeight - 100, curveHeight)
      ..quadraticBezierTo(size.width, curveHeight, size.width, size.width - 150)
      ..lineTo(size.width, 0);

    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
