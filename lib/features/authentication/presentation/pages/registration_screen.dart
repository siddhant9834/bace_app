import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/routes/page_route_constants.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/side_drawer/data/datasource/FB_services.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/authentication/data/FireB_auth_impl_datasource.dart/firebase_auth_services_impl.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_event.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_state.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // final FirebaseAuthService _auth = FirebaseAuthService();
// class AuthService

  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _newFullNameNameController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPhoneNumberController =
      TextEditingController();

  @override
  void dispose() {
    _newEmailController.dispose();
    _newFullNameNameController.dispose();
    _newPasswordController.dispose();
    _newPhoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorPallete.whiteColor,
        backgroundColor: ColorPallete.whiteColor,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Register',
            style: TextStyle(
              fontSize: 20,
              color: ColorPallete.blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        elevation: 1,
        shadowColor: Colors.black,
      ),
      backgroundColor: ColorPallete.whiteColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserRegisteredState) {
            if (state.message.contains('Success')) {
              context.go('/login');
              log('Register Event: ${state.message}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  padding: EdgeInsets.all(20),
                  backgroundColor: Colors.teal,
                  content: Text(
                      'Welcome to Mayapur Bace, now you can proceed to login'),
                ),
              );
            }
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.teal,
                content: Text(
                  state.message,
                  style: Fonts.ubuntu(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.blackColor),
                ),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPallete.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextFormField(
                    controller: _newFullNameNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Ex- Siddhant Nilage',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                // Expanded(child: SizedBox()),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPallete.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextFormField(
                    controller: _newEmailController,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      hintText: 'Ex- siddhantn2002@gmail.com',
                      fillColor: const Color.fromARGB(255, 18, 18, 18),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(8.0),
                      //   borderSide: BorderSide(),
                      // ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                // Expanded(child: SizedBox()),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPallete.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: _newPhoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Ex- 9834599998',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                    fillColor: const Color.fromARGB(255, 18, 18, 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (value.length != 10) {
                      return 'Please enter a 10-digit phone number';
                    }
                    return null;
                  },
                ),
                // Expanded(child: SizedBox()),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPallete.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextFormField(
                    controller: _newPasswordController,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      hintText: 'It\'s your choice',
                      fillColor: const Color.fromARGB(255, 18, 18, 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                // Expanded(child: SizedBox()),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                    backgroundColor: ColorPallete.blueColor,
                    textStyle: const TextStyle(
                      color: Color.fromARGB(238, 255, 255, 255),
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  onPressed: () async {
                    // final message = await locator<AuthService>().registration(
                    //   email: _newEmailController.text,
                    //   password: _newPasswordController.text,
                    //   phoneNumber: _newPhoneNumberController.text,
                    //   fullName: _newFullNameNameController.text,
                    BlocProvider.of<AuthBloc>(context).add(RegisterUserEvent(
                      email: _newEmailController.text,
                      password: _newPasswordController.text,
                      fullName: _newFullNameNameController.text,
                      phoneNumber: _newPhoneNumberController.text,
                    ));
                  },
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
