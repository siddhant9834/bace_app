
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/features/authentication/domain/usecases/auth_usecases.dart';

import 'package:shared_preferences/shared_preferences.dart';

// class Users {
//   final String username;
//   final String password;

//   Users({required this.username, required this.password});
// }

class StaticUsers {
  // static List<Users> users = [
  //   Users(username: 'Siddhant', password: 'Sidd@12345'),
  //   Users(username: 'Sidd', password: 'Sidd@12345'),
  // ];

  // static Users? getUser(String username) {
  //   return users.firstWhere((user) => user.username == username, orElse: () => null);
  // }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // bool validateCredentials(String username, String password) {
  //   for (var user in StaticUsers.users) {
  //     if (user.username == username && user.password == password) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(flex: 1, child: SizedBox()),
                SvgPicture.asset(
                  'assets/icons/coditas_logo.svg',
                  height: 96,
                  width: 32,
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPallete.blueColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextFormField(
                    controller: emailController,
                    // maxLength: 15,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      // labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Enter email',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      // focusedBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(18)),
                      //   borderSide: BorderSide(color: Colors.blue),
                      // ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //  Expanded(
                //   // flex: 1,
                //   // flex: 20,
                //   child: SizedBox(

                //   ),
                // ),
                // SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorPallete.blackColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextFormField(
                    controller: passwordController,
                    // maxLength: 20,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      // labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Enter password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      // focusedBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(18)),
                      //   borderSide: BorderSide(color: Colors.blue),
                      // ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Please enter your password'
                          : null;
                    },
                  ),
                ),
                const Expanded(
                  // flex: 36,
                  flex: 1,
                  child: SizedBox(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ), // Add border radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 48),
                    backgroundColor: ColorPallete.blueColor,
                    textStyle: const TextStyle(
                        color: Color.fromARGB(238, 255, 255, 255),
                        fontSize: 24,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () async {
                    
                      FirebaseAnalytics.instance.logLogin(
                          loginMethod: 'email',
                          parameters: <String, dynamic>{
                            'signup_method': 'Email and password',
                          });
                      final message = await locator<AuthUseCases>().loginUser(
                          emailController.text, passwordController.text);

                      if (message!.contains('Success')) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool('isLoggedIn', true);
                        context.push('/home');

                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => const Home(),
                        //   ),
                        // );
                      }
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );

   
                      FirebaseCrashlytics.instance.log(message);
                      // FirebaseCrashlytics.instance.crash();

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //         'An unexpected error occurred. Please try again.'),
                      //   ),
                      // );
                  
                    // if (formKey.currentState!.validate()) {
                    //   String username = usernameController.text;
                    //   String password = passwordController.text;
                    //   if (validateCredentials(username, password)) {
                    //     var sharedPref = await SharedPreferences.getInstance();
                    //     sharedPref.setBool(SplashScreenState.loginStatus, true);
                    //     context.go('/home');
                    //     print("********Valid Data");
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text('Invalid username or password')),
                    //     );
                    //   }
                    // }
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Expanded(
                //   child: SizedBox(
                //     height: 16,
                //   ),
                // ),
                TextButton(
                  onPressed: () {
                    // context.go('/register');
                    // GoRouter.of(context)
                    //     .pushNamed(MyAppRouteConstants.registerRouteName);
                  },
                  child: Text(
                    'Don’t have an account yet? Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorPallete.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(flex: 2, child: SizedBox()),
                Padding(padding: EdgeInsets.only(top: 10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
