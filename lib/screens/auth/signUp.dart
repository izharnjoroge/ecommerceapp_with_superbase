import 'package:ecommerceapp/models/location_model.dart';
import 'package:ecommerceapp/repos/auth/auth.dart';
import 'package:ecommerceapp/repos/locationRepo/location_repo.dart';
import 'package:ecommerceapp/screens/landing%20page/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final Auth auth = Auth();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  String response = '';
  bool isLoading = false;
  bool _isPasswordVisible = false;

  final LocationRepo _locationRepo = LocationRepo();
  List<ListLocationModel> _locations = [];
  ListLocationModel? _selectedLocation;
  String? _selectedStreet;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
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

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 characters long';
    }
    return null;
  }

  void _signUp() async {
    setState(() {
      isLoading = true;
    });

    if ((!_signUpFormKey.currentState!.validate())) {
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
      final email = _emailController.text;
      final password = _passwordController.text;
      final name = _nameController.text;
      final phone = _phoneController.text;

      response = await auth.signUp(email, password, name, phone,
          _selectedLocation?.area, _selectedStreet);

      if (response == 'Welcome') {
        Get.offAll(() => const LandingPage());
        Get.snackbar('Welcome', '',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            duration: const Duration(seconds: 3));
      } else {
        setState(() {
          isLoading = false;
        });

        Get.snackbar('An error occurred', 'Please try again',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            duration: const Duration(seconds: 3));
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    _getLocations();
    super.initState();
  }

  _getLocations() async {
    try {
      final locations = await _locationRepo.getLocations();
      setState(() {
        _locations = locations;
      });
    } catch (e) {
      Get.back();
      Get.snackbar('An error occurred', 'Please try retry',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 3));
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
          'Create An Account',
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
                  key: _signUpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person_2_outlined),
                            iconColor: Colors.purple,
                            labelText: 'User Name',
                            labelStyle: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
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
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                              hintText: 'Enter your email',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            return validateEmail(val ?? '');
                          }),
                      const Gap(20),
                      TextFormField(
                          controller: _phoneController,
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
                      DropdownButtonFormField<ListLocationModel>(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_city),
                          iconColor: Colors.purple,
                          labelText: 'Area',
                          labelStyle: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)),
                        ),
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(location.area),
                          );
                        }).toList(),
                        onChanged: (location) {
                          setState(() {
                            _selectedLocation = location;
                            _selectedStreet = null; // Reset selected street
                          });
                        },
                        value: _selectedLocation,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an area';
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      if (_selectedLocation != null)
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.streetview),
                            iconColor: Colors.purple,
                            labelText: 'Street',
                            labelStyle: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                          ),
                          items: _selectedLocation!.streets.map((street) {
                            return DropdownMenuItem(
                              value: street,
                              child: Text(street),
                            );
                          }).toList(),
                          onChanged: (street) {
                            setState(() {
                              _selectedStreet = street;
                            });
                          },
                          value: _selectedStreet,
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a street';
                            }
                            return null;
                          },
                        ),
                      const Gap(20),
                      TextFormField(
                        controller: _passwordController,
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
                                color: Colors.purple,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple))),
                        obscureText: _isPasswordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          return validatePassword(val ?? '');
                        },
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _signUp,
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
          ),
        ),
      ),
    );
  }
}
