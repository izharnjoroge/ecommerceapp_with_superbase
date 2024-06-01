import 'package:ecommerceapp/repos/auth/auth.dart';
import 'package:ecommerceapp/screens/auth/signIn.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final Auth auth = Auth();
  final TextEditingController _emailController = TextEditingController();
  final _forgotPasswordFormKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: const Text(
          'Reset Password',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Form(
            key: _forgotPasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email_outlined),
                        iconColor: Colors.purple,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                        hintText: 'Enter your email',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple))),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      validateEmail(_emailController.text);
                      return null;
                    }),
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

                            if ((!_forgotPasswordFormKey.currentState!
                                .validate())) {
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

                              response = await auth.forgotPassword(email);
                              if (response == 'Success') {
                                Get.offAll(() => const LoginScreen());
                                Get.snackbar(
                                    'Successful', 'Please check your mail',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: true,
                                    duration: const Duration(seconds: 3));
                              } else {
                                Get.snackbar(response, '',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: true,
                                    duration: const Duration(seconds: 3));
                                setState(() {
                                  isLoading = false;
                                });
                                Get.back();
                              }
                            }
                          },
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    'Reset Password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: RichText(
                          selectionColor: Colors.grey,
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'Have an account?  ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ))
                          ])),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
