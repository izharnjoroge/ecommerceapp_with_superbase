import 'dart:developer';

import 'package:ecommerceapp/repos/auth/auth.dart';
import 'package:ecommerceapp/screens/auth/signIn.dart';
import 'package:ecommerceapp/screens/landing%20page/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/location_model.dart';
import '../../repos/locationRepo/location_repo.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final supabase = Supabase.instance.client;
  final Auth auth = Auth();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _settingsFormKey = GlobalKey<FormState>();

  String response = '';
  bool isLoading = false;

  final LocationRepo _locationRepo = LocationRepo();
  List<ListLocationModel> _locations = [];
  ListLocationModel? _selectedLocation;
  final ListLocationModel _selectedLocationReturn =
      ListLocationModel(id: '1', area: '', streets: []);
  String? _selectedStreet;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
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
      _initializeUserDetails();
    } catch (e) {
      Get.back();
      Get.snackbar('An error occurred', 'Please try again',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 3));
    }
  }

  void _initializeUserDetails() {
    final user = supabase.auth.currentUser;
    final userMetadata = user?.userMetadata;

    _nameController.text = userMetadata?['username'] ?? '';
    _emailController.text = user?.email ?? '';
    _phoneController.text = userMetadata?['phone'] ?? '';

    if (userMetadata != null) {
      final userArea = userMetadata['area'];
      final userStreet = userMetadata['street'];

      if (userArea != null && userArea != '') {
        _selectedLocation = _locations.firstWhere(
          (location) => location.area == userArea,
          orElse: () => _selectedLocationReturn,
        );
      }

      if (_selectedLocation != null && userStreet != null) {
        _selectedStreet =
            _selectedLocation!.streets.contains(userStreet) ? userStreet : null;
      }
    }
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteAccount();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteAccount() async {
    setState(() {
      isLoading = true;
    });

    response = await auth.deleteAccount();
    if (response == 'successful') {
      Get.offAll(() => const LoginScreen());
      Get.snackbar(
          'Account Deleted', 'Your account has been deleted successfully.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 5));
    } else {
      log('res;$response');
      setState(() {
        isLoading = false;
      });
      Get.snackbar(
          'An error occurred', 'Unable to delete account. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          isDismissible: true,
          duration: const Duration(seconds: 5));
    }
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

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 characters long';
    }
    return null;
  }

  void _update() async {
    setState(() {
      isLoading = true;
    });

    if ((!_settingsFormKey.currentState!.validate())) {
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
      final name = _nameController.text;
      final phone = _phoneController.text;

      response = await auth.updateUserDetails(
          name, phone, _selectedLocation?.area, _selectedStreet);

      if (response == 'updated') {
        Get.offAll(() => const LandingPage());
        Get.snackbar('Details Updated', '',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            duration: const Duration(seconds: 5));
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
          'Settings',
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
                  key: _settingsFormKey,
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
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: 'Enter your User Name',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter a valid Name";
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      TextFormField(
                        controller: _emailController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email_outlined),
                          iconColor: Colors.purple,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: 'Enter your email',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          return validateEmail(val ?? '');
                        },
                      ),
                      const Gap(20),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          iconColor: Colors.purple,
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: 'Enter your phone number',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          return validatePhone(val ?? '');
                        },
                      ),
                      const Gap(20),
                      DropdownButtonFormField<ListLocationModel>(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_city),
                          iconColor: Colors.purple,
                          labelText: 'Area',
                          labelStyle: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
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
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _update,
                            child: SizedBox(
                              height: size.height * .05,
                              width: size.width * .3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'Update',
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
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _confirmDeleteAccount,
                            child: SizedBox(
                              height: size.height * .05,
                              width: size.width - 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'Delete Account',
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
                      const Gap(40),
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
