import 'package:ecommerceapp/screens/auth/signUp.dart';
import 'package:ecommerceapp/screens/auth/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../repos/auth/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Auth auth = Auth();
  final TextEditingController _emailController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  String response = '';
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    if (!value.contains('.')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _signIn() async {
    setState(() {
      isLoading = true;
    });
    if (!_loginFormKey.currentState!.validate()) {
      Get.snackbar("Error", "Please fill all the fields correctly",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 5));
      setState(() {
        isLoading = false;
      });
    } else {
      final email = _emailController.text;

      response = await auth.signIn(email);

      if (response == 'Success') {
        Get.to(() => VerifyOtp(
              email: _emailController.text,
            ));

        Get.snackbar(
            'One Time Pin sent to your email', 'Please check your Inbox',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            duration: const Duration(seconds: 8));
      } else {
        setState(() {
          isLoading = false;
        });
        Get.snackbar('An error occurred', 'Check your connection and try again',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            duration: const Duration(seconds: 8));
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(20),
                    Lottie.asset("assets/lotties/login.json",
                        height: size.height * .4),
                    const Gap(20),
                    TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          iconColor: Colors.purple,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                          hintText: 'Enter your email',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple))),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        return validateEmail(val ?? '');
                      },
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _signIn,
                          child: SizedBox(
                            height: size.height * .05,
                            width: size.width * .3,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(20)),
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Center(
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(50),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SignUp());
                      },
                      child: RichText(
                          selectionColor: Colors.grey,
                          text: const TextSpan(children: [
                            TextSpan(
                                text: "Don't have an account?  ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ))
                          ])),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
