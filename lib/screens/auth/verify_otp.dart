import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../repos/auth/auth.dart';
import '../landing page/load_screen.dart';

class VerifyOtp extends StatefulWidget {
  final String phone;
  VerifyOtp({super.key, required this.phone});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final Auth auth = Auth();

  final TextEditingController _otpController = TextEditingController();

  final _otpFormKey = GlobalKey<FormState>();
  String response = '';
  bool isLoading = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'Please enter the code sent to your phone';
    }
    return null;
  }

  void _checkOtp() async {
    setState(() {
      isLoading = true;
    });

    if ((!_otpFormKey.currentState!.validate())) {
      Get.snackbar("Error", "Please fill all the fields",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 3));
      setState(() {
        isLoading = false;
      });
    } else {
      final otp = _otpController.text;

      response = await auth.verifyOtp(otp, widget.phone);

      if (response == 'Welcome') {
        Get.offAll(() => const LandingPage());
        Get.snackbar(response, '',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            duration: const Duration(seconds: 3));
      } else {
        setState(() {
          isLoading = false;
        });
        Get.snackbar(response, '',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            duration: const Duration(seconds: 3));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: const Text(
          'Verify Phone Number',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Form(
                  key: _otpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      TextFormField(
                          controller: _otpController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.phone),
                              iconColor: Colors.purple,
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                              hintText: 'Enter your phone number',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            return validatePhone(val ?? '');
                          }),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _checkOtp,
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
                                          color: Colors.purple,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'Sign Up',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
