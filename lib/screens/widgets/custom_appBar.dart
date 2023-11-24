import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

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
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_2_outlined,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  // Path getClip(Size size) {
  //   final path = Path();
  //   const radius = 20.0;

  //   path.lineTo(0, size.height - radius);
  //   path.quadraticBezierTo(
  //       size.width / 4, size.height, size.width / 2, size.height);
  //   path.quadraticBezierTo(
  //       3 * size.width / 4, size.height, size.width, size.height - radius);
  //   path.lineTo(size.width, 0);
  //   path.close();

  //   return path;
  // }
  @override
  Path getClip(Size size) {
    double curveHeight = size.height / 1.6;
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
