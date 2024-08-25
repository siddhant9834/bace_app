import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/features/authentication/data/datasource/auth_datasource.dart';


class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // final FirebaseAuthService _auth = FirebaseAuthService();
// class AuthService

  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _newUserNameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _newEmailController.dispose();
    _newUserNameController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorPallete.whiteTextColor,
        backgroundColor: ColorPallete.whiteTextColor
        ,
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            SizedBox(height: 194),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Given Name',
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
                controller: _newUserNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue),
                  hintText: 'Enter Username',
                  hintStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(child: SizedBox(height: 20)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter Email',
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: 'Enter Email',
                  fillColor: const Color.fromARGB(255, 18, 18, 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox(height: 20)),
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: 'Enter password',
                  fillColor: const Color.fromARGB(255, 18, 18, 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox(height: 23)),
            ElevatedButton(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 14,
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
                FirebaseAnalytics.instance.logSignUp(
                    signUpMethod: 'email_id and username',
                    parameters: <String, dynamic>{
                      'new_account_method': 'Email, password and username',
                    });
                final message = await locator<AuthService>().registration(
                    email: _newEmailController.text,
                    password: _newPasswordController.text);
                print('1');

                if (message!.contains('Success')) {
                  // context.pushNamed('/home');
                  // print('pushed');
                  // context.pushNamed(
                  //   MyAppRouteConstants.loginRouteName,
                  // );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
            ),
            SizedBox(height: 139),
          ],
        ),
      ),
    );
  }
}
