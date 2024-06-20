import 'package:ecommerceapp/repos/auth/auth.dart';
import 'package:ecommerceapp/screens/auth/signIn.dart';
import 'package:ecommerceapp/screens/pages/cart_page.dart';
import 'package:ecommerceapp/screens/pages/order_page.dart';
import 'package:ecommerceapp/screens/pages/user_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final userMetadata = user?.userMetadata;

    String username = userMetadata?['username'] ?? '';
    // if (user?.email != null) {
    //   username = extractUsername(user!.email!);
    // }

    return Drawer(
      child: Stack(children: [
        Column(
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
              leading: const Icon(Icons.bookmark, color: Colors.purple),
              title: const Text('My Orders'),
              onTap: () {
                Get.to(() => const MyOrders());
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.purple),
              title: const Text('Settings'),
              onTap: () {
                Get.to(() => const UserSettings());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.purple,
              ),
              title: const Text('Call Us'),
              onTap: () {
                _launchURL('tel:+254704162361');
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.purple),
              title: const Text('WhatsApp Us'),
              onTap: () {
                _launchURL('https://wa.me/+254704162361');
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.purple),
              title: const Text('Log Out'),
              onTap: () async {
                await auth.signOut();
                Get.offAll(() => const LoginScreen());
              },
            ),
          ],
        ),
        Positioned(
          top: 20,
          right: 16,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ]),
    );
  }
}

void _launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    Get.snackbar('An error occurred', 'Requested Application not installed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        duration: const Duration(seconds: 5));
  }

  // if (Platform.isAndroid) {
  //     // add the [https]
  //     return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
  //   } else {
  //     // add the [https]
  //     return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
  //   }
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
