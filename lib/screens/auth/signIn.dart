import 'package:ecommerceapp/screens/auth/signUp.dart';
import 'package:ecommerceapp/screens/landing%20page/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  String responce = '';
  bool isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ),
                ],
              )
            : Form(
                key: _loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      // SvgPicture.asset(
                      //   'assets/svg/cart_fast.svg',
                      //   color: Colors.purple,
                      //   height: 100,
                      // ),
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
                          validateEmail(_emailController.text);
                          return null;
                        },
                      ),
                      const Gap(20),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.key_outlined),
                            iconColor: Colors.purple,
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                !_isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple))),
                        obscureText: _isPasswordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          validatePassword(_passwordController.text);
                          return null;
                        },
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: size.height * .05,
                            width: size.width * .3,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(20)),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  if (_emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    Get.snackbar(
                                        "Error", "Please fill all the fields",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        isDismissible: true,
                                        duration: const Duration(seconds: 3));
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else if (!_loginFormKey.currentState!
                                      .validate()) {
                                    Get.snackbar(
                                        "Error", "Please fill all the fields",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        isDismissible: true,
                                        duration: const Duration(seconds: 3));
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    final email = _emailController.text;
                                    final password = _passwordController.text;

                                    if (responce == 'Success') {
                                      setState(() {
                                        isLoading = false;
                                      });

                                      Get.snackbar(responce, '',
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM,
                                          isDismissible: true,
                                          duration: const Duration(seconds: 3));

                                      Get.offAll(() => const LandingPage());
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Get.snackbar(responce, '',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM,
                                          isDismissible: true,
                                          duration: const Duration(seconds: 3));
                                      Get.back();
                                    }
                                  }
                                },
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.purple,
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
                          const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignUp());
                        },
                        child: RichText(
                            selectionColor: Colors.grey,
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: 'Dont have an account?  ',
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
    );
  }
}
