import 'package:ecommerceapp/repos/auth/auth.dart';
import 'package:ecommerceapp/screens/auth/signIn.dart';
import 'package:ecommerceapp/screens/pages/cart_page.dart';
import 'package:ecommerceapp/screens/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final supabase = Supabase.instance.client;
  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    String username = "User";
    if (user?.email != null) {
      username = extractUsername(user!.email!);
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Welcome , $username'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user?.email?.substring(0, 2).toUpperCase() ?? '',
                style: const TextStyle(fontSize: 40.0),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.purple,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('My Orders'),
            onTap: () {
              Get.to(() => const MyOrders());
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Shopping Cart'),
            onTap: () {
              Get.to(() => const CartPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () async {
              await auth.signOut();
              Get.offAll(() => const LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}

// Function to extract and format username from email
String extractUsername(String email) {
  final localPart = email.split('@')[0];
  final formattedPart = localPart.replaceAll(RegExp(r'[\._\-]'), ' ');
  final words = formattedPart.split(' ');

  final capitalizedWords = words.map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
    return '';
  });

  return capitalizedWords.join(' ');
}
