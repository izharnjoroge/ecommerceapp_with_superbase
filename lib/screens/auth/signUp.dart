import 'dart:typed_data';
import 'package:ecommerceapp/screens/landing%20page/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _pickedFile;
  String responce = '';
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _bioController.dispose();
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
    if (!value.contains('.')) {
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

  void _getImageFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List photo = await pickedFile.readAsBytes();
      setState(() {
        _pickedFile = photo;
      });
    }
  }

  void _takePhoto() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      Uint8List photo = await pickedFile.readAsBytes();
      setState(() {
        _pickedFile = photo;
      });
    }
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
          'Create An Account',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Form(
            key: _signUpFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey,
                      backgroundImage: _pickedFile != null
                          ? MemoryImage(_pickedFile!)
                          : null,
                      child: _pickedFile == null
                          ? const Icon(
                              Icons.person_outline,
                              size: 60,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 18,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.file_upload,
                        ),
                        onPressed: _getImageFromGallery,
                      ),
                    ),
                    Positioned(
                      bottom: 18,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.camera),
                        onPressed: _takePhoto,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person_2_outlined),
                      iconColor: Colors.purple,
                      labelText: 'User Name',
                      labelStyle: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                      hintText: 'Enter your User Name',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple))),
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter valid Name";
                    }
                    return null;
                  },
                ),
                const Gap(20),
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
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.key_outlined),
                      iconColor: Colors.purple,
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                      hintText: 'Enter your password',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple))),
                  obscureText: true,
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
                                _passwordController.text.isEmpty ||
                                _nameController.text.isEmpty) {
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
                            } else if ((!_signUpFormKey.currentState!
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
                              final password = _passwordController.text;
                              final name = _nameController.text;
                              final image = _pickedFile;

                              if (responce == 'Welcome') {
                                Get.snackbar(responce, '',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: true,
                                    duration: const Duration(seconds: 3));
                                setState(() {
                                  isLoading = false;
                                });
                                Get.offAll(() => const LandingPage());
                              } else {
                                Get.snackbar(responce, '',
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
