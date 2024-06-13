// import 'dart:typed_data';
// import 'package:ecommerceapp/models/location_model.dart';
// import 'package:ecommerceapp/repos/auth/auth.dart';
// import 'package:ecommerceapp/repos/locationRepo/location_repo.dart';
// import 'package:ecommerceapp/screens/landing%20page/load_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final Auth auth = Auth();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();

//   final _signUpFormKey = GlobalKey<FormState>();

//   final ImagePicker _picker = ImagePicker();
//   Uint8List? _pickedFile;

//   String response = '';
//   bool isLoading = false;
//   bool _isPasswordVisible = false;

//   final LocationRepo _locationRepo = LocationRepo();
//   ListLocationModel _locationModel =
//       ListLocationModel(id: '', area: '', streets: []);

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _nameController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   String? validateEmail(String value) {
//     if (value.isEmpty) {
//       return 'Please enter your email';
//     }
//     if (!value.contains('@')) {
//       return 'Please enter a valid email address';
//     }
//     if (!value.contains('.')) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   String? validatePassword(String value) {
//     if (value.isEmpty) {
//       return 'Please enter your password';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters long';
//     }
//     return null;
//   }

//   String? validatePhone(String value) {
//     if (value.isEmpty) {
//       return 'Please enter your phone number';
//     }
//     if (value.length != 10) {
//       return 'Phone number must be 10 characters long';
//     }
//     return null;
//   }

//   void _getImageFromGallery() async {
//     XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       Uint8List photo = await pickedFile.readAsBytes();
//       setState(() {
//         _pickedFile = photo;
//       });
//     }
//   }

//   void _takePhoto() async {
//     XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       Uint8List photo = await pickedFile.readAsBytes();
//       setState(() {
//         _pickedFile = photo;
//       });
//     }
//   }

//   void _signUp() async {
//     setState(() {
//       isLoading = true;
//     });

//     if ((!_signUpFormKey.currentState!.validate())) {
//       Get.snackbar("Error", "Please fill all the fields",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//           isDismissible: true,
//           duration: const Duration(seconds: 3));
//       setState(() {
//         isLoading = false;
//       });
//     } else {
//       final email = _emailController.text;
//       final password = _passwordController.text;
//       final name = _nameController.text;
//       final phone = _phoneController.text;

//       response = await auth.signUp(email, password, name, phone);

//       if (response == 'Welcome') {
//         // Get.to(() => VerifyOtp(phone: phone));
//         Get.offAll(() => const LandingPage());
//         Get.snackbar('Welcome', '',
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//             snackPosition: SnackPosition.BOTTOM,
//             isDismissible: true,
//             duration: const Duration(seconds: 3));
//       } else {
//         setState(() {
//           isLoading = false;
//         });

//         Get.snackbar('An error occurred', 'Check your connection and try again',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//             snackPosition: SnackPosition.BOTTOM,
//             isDismissible: true,
//             duration: const Duration(seconds: 3));
//       }
//     }
//   }

//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }

//   @override
//   void initState() {
//     _getLocations();
//     super.initState();
//   }

//   _getLocations() async {
//     try {
//       final locations = await _locationRepo.getLocations();
//       _locationModel = locations;
//     } catch (e) {
//       Get.back();
//       Get.snackbar('An error occurred', 'Check your connection and try again',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//           isDismissible: true,
//           duration: const Duration(seconds: 3));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         automaticallyImplyLeading: true,
//         title: const Text(
//           'Create An Account',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: MediaQuery.of(context).size.height,
//             ),
//             child: IntrinsicHeight(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 32),
//                 width: double.infinity,
//                 child: Form(
//                   key: _signUpFormKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Gap(20),
//                       // Stack(
//                       //   alignment: Alignment.center,
//                       //   children: [
//                       //     CircleAvatar(
//                       //       radius: 100,
//                       //       backgroundColor: Colors.grey.shade300,
//                       //       backgroundImage: _pickedFile != null
//                       //           ? MemoryImage(_pickedFile!)
//                       //           : null,
//                       //       child: _pickedFile == null
//                       //           ? const Icon(
//                       //               Icons.person_outline,
//                       //               size: 60,
//                       //               color: Colors.white,
//                       //             )
//                       //           : null,
//                       //     ),
//                       //     Positioned(
//                       //       bottom: 18,
//                       //       right: 10,
//                       //       child: Material(
//                       //         color: Colors.transparent,
//                       //         shape: const CircleBorder(),
//                       //         elevation: 4,
//                       //         child: CircleAvatar(
//                       //           backgroundColor: Colors.white,
//                       //           radius: 20,
//                       //           child: IconButton(
//                       //             icon: const Icon(
//                       //               Icons.file_upload,
//                       //               color: Colors.grey,
//                       //             ),
//                       //             onPressed: _getImageFromGallery,
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     Positioned(
//                       //       bottom: 18,
//                       //       left: 16,
//                       //       child: Material(
//                       //         color: Colors.transparent,
//                       //         shape: const CircleBorder(),
//                       //         elevation: 4,
//                       //         child: CircleAvatar(
//                       //           backgroundColor: Colors.white,
//                       //           radius: 20,
//                       //           child: IconButton(
//                       //             icon: const Icon(
//                       //               Icons.camera,
//                       //               color: Colors.grey,
//                       //             ),
//                       //             onPressed: _takePhoto,
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       const Gap(20),
//                       TextFormField(
//                         controller: _nameController,
//                         decoration: const InputDecoration(
//                             icon: Icon(Icons.person_2_outlined),
//                             iconColor: Colors.purple,
//                             labelText: 'User Name',
//                             labelStyle: TextStyle(
//                                 color: Colors.purple,
//                                 fontWeight: FontWeight.bold),
//                             hintText: 'Enter your User Name',
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.purple))),
//                         keyboardType: TextInputType.name,
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (val) {
//                           if (val == null || val.isEmpty) {
//                             return "Please enter valid Name";
//                           }
//                           return null;
//                         },
//                       ),
//                       const Gap(20),
//                       TextFormField(
//                           controller: _emailController,
//                           decoration: const InputDecoration(
//                               icon: Icon(Icons.email_outlined),
//                               iconColor: Colors.purple,
//                               labelText: 'Email',
//                               labelStyle: TextStyle(
//                                   color: Colors.purple,
//                                   fontWeight: FontWeight.bold),
//                               hintText: 'Enter your email',
//                               focusedBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.purple))),
//                           keyboardType: TextInputType.emailAddress,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (val) {
//                             return validateEmail(val ?? '');
//                           }),
//                       const Gap(20),
//                       TextFormField(
//                           controller: _phoneController,
//                           decoration: const InputDecoration(
//                               icon: Icon(Icons.phone),
//                               iconColor: Colors.purple,
//                               labelText: 'Phone Number',
//                               labelStyle: TextStyle(
//                                   color: Colors.purple,
//                                   fontWeight: FontWeight.bold),
//                               hintText: 'Enter your phone number',
//                               focusedBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.purple))),
//                           keyboardType: TextInputType.number,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (val) {
//                             return validatePhone(val ?? '');
//                           }),
//                       const Gap(20),
//                       TextFormField(
//                         controller: _passwordController,
//                         decoration: InputDecoration(
//                             icon: const Icon(Icons.key_outlined),
//                             iconColor: Colors.purple,
//                             labelText: 'Password',
//                             labelStyle: const TextStyle(
//                                 color: Colors.purple,
//                                 fontWeight: FontWeight.bold),
//                             hintText: 'Enter your password',
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 !_isPasswordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Colors.purple,
//                               ),
//                               onPressed: _togglePasswordVisibility,
//                             ),
//                             focusedBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.purple))),
//                         obscureText: _isPasswordVisible,
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (val) {
//                           return validatePassword(val ?? '');
//                         },
//                       ),
//                       const Gap(20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: _signUp,
//                             child: SizedBox(
//                               height: size.height * .05,
//                               width: size.width * .3,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.purple,
//                                     borderRadius: BorderRadius.circular(20)),
//                                 child: isLoading
//                                     ? const Center(
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     : const Center(
//                                         child: Text(
//                                           'Continue',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () => Get.back(),
//                             child: RichText(
//                                 selectionColor: Colors.grey,
//                                 text: const TextSpan(children: [
//                                   TextSpan(
//                                       text: 'Have an account?  ',
//                                       style: TextStyle(
//                                           color: Colors.grey,
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(
//                                       text: 'Sign In',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.purple,
//                                       ))
//                                 ])),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




//user;{email: king9jim6@gmail.com, email_verified: false, phone: 0704162361, phone_verified: false, sub: 07984414-5eef-456c-a4e8-0c21badf7377, username: king}






// import 'package:ecommerceapp/screens/auth/forgotPassword.dart';
// import 'package:ecommerceapp/screens/auth/signUp.dart';
// import 'package:ecommerceapp/screens/auth/verify_otp.dart';
// import 'package:ecommerceapp/screens/landing%20page/load_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

// import '../../repos/auth/auth.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final Auth auth = Auth();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _loginFormKey = GlobalKey<FormState>();
//   bool _isPasswordVisible = false;
//   String response = '';
//   bool isLoading = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   String? validateEmail(String value) {
//     if (value.isEmpty) {
//       return 'Please enter your email';
//     }
//     if (!value.contains('@')) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   _signIn() async {
//     setState(() {
//       isLoading = true;
//     });
//     if (!_loginFormKey.currentState!.validate()) {
//       Get.snackbar("Error", "Please fill all the fields correctly",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//           isDismissible: true,
//           duration: const Duration(seconds: 5));
//       setState(() {
//         isLoading = false;
//       });
//     } else {
//       final email = _emailController.text;

//       response = await auth.signIn(email);

//       if (response == 'Success') {
//         Get.to(() => VerifyOtp(
//               email: _emailController.text,
//             ));

//         Get.snackbar(
//             'One Time Pin sent to your email', 'Please check your Inbox',
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//             snackPosition: SnackPosition.BOTTOM,
//             isDismissible: true,
//             duration: const Duration(seconds: 8));
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         Get.snackbar('An error occurred', 'Check your connection and try again',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//             snackPosition: SnackPosition.BOTTOM,
//             isDismissible: true,
//             duration: const Duration(seconds: 8));
//         Get.back();
//       }
//     }
//   }

//   // String? validatePassword(String value) {
//   //   if (value.isEmpty) {
//   //     return 'Please enter your password';
//   //   }
//   //   if (value.length < 6) {
//   //     return 'Password must be at least 6 characters long';
//   //   }
//   //   return null;
//   // }

//   // void _togglePasswordVisibility() {
//   //   setState(() {
//   //     _isPasswordVisible = !_isPasswordVisible;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: MediaQuery.of(context).size.height,
//             ),
//             child: IntrinsicHeight(
//               child: isLoading
//                   ? const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.purple,
//                           ),
//                         ),
//                       ],
//                     )
//                   : Form(
//                       key: _loginFormKey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Gap(20),
//                           Lottie.asset("assets/lotties/login.json",
//                               height: size.height * .4),
//                           const Gap(20),
//                           TextFormField(
//                             controller: _emailController,
//                             cursorColor: Colors.black,
//                             decoration: const InputDecoration(
//                                 icon: Icon(Icons.email),
//                                 iconColor: Colors.purple,
//                                 labelText: 'Email',
//                                 labelStyle: TextStyle(
//                                     color: Colors.purple,
//                                     fontWeight: FontWeight.bold),
//                                 hintText: 'Enter your email',
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Colors.purple))),
//                             keyboardType: TextInputType.emailAddress,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             validator: (val) {
//                               validateEmail(_emailController.text);
//                               return null;
//                             },
//                           ),
//                           const Gap(20),
//                           // TextFormField(
//                           //   controller: _passwordController,
//                           //   keyboardType: TextInputType.text,
//                           //   decoration: InputDecoration(
//                           //       icon: const Icon(Icons.key_outlined),
//                           //       iconColor: Colors.purple,
//                           //       labelText: 'Password',
//                           //       labelStyle: const TextStyle(
//                           //           color: Colors.purple,
//                           //           fontWeight: FontWeight.bold),
//                           //       hintText: 'Enter your password',
//                           //       suffixIcon: IconButton(
//                           //         icon: Icon(
//                           //           !_isPasswordVisible
//                           //               ? Icons.visibility
//                           //               : Icons.visibility_off,
//                           //           color: Colors.purple,
//                           //         ),
//                           //         onPressed: _togglePasswordVisibility,
//                           //       ),
//                           //       focusedBorder: const UnderlineInputBorder(
//                           //           borderSide:
//                           //               BorderSide(color: Colors.purple))),
//                           //   obscureText: _isPasswordVisible,
//                           //   autovalidateMode:
//                           //       AutovalidateMode.onUserInteraction,
//                           //   validator: (val) {
//                           //     validatePassword(_passwordController.text);
//                           //     return null;
//                           //   },
//                           // ),
//                           // const Gap(20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               GestureDetector(
//                                 onTap: _signIn,
//                                 child: SizedBox(
//                                   height: size.height * .05,
//                                   width: size.width * .3,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.purple,
//                                         borderRadius:
//                                             BorderRadius.circular(20)),
//                                     child: isLoading
//                                         ? const Center(
//                                             child: CircularProgressIndicator(
//                                               color: Colors.purple,
//                                             ),
//                                           )
//                                         : const Center(
//                                             child: Text(
//                                               'Continue',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                   ),
//                                 ),
//                               ),
//                               // GestureDetector(
//                               //   onTap: () =>
//                               //       Get.to(() => const ForgotPassword()),
//                               //   child: const Text(
//                               //     'Forgot Password?',
//                               //     style: TextStyle(
//                               //         color: Colors.purple,
//                               //         fontWeight: FontWeight.bold),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           const Gap(50),
//                           TextButton(
//                             onPressed: () {
//                               Get.to(() => const SignUp());
//                             },
//                             child: RichText(
//                                 selectionColor: Colors.grey,
//                                 text: const TextSpan(children: [
//                                   TextSpan(
//                                       text: "Don't have an account?  ",
//                                       style: TextStyle(
//                                           color: Colors.grey,
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(
//                                       text: 'Sign Up',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.purple,
//                                       ))
//                                 ])),
//                           ),
//                         ],
//                       ),
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
