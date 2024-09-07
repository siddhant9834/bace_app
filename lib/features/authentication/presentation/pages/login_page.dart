
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_event.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  static const String keylogin = 'Login';
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
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final sharedPref = await SharedPreferences.getInstance();
    final isLoggedIn = sharedPref.getBool(keylogin) ?? false;
    if (isLoggedIn) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is UserAuthenticated) {
            if (state.message!.contains('Success')) {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setBool(keylogin, true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  padding: EdgeInsets.all(20),
                  backgroundColor: Colors.teal,
                  content: Text(
                    "Logged in Successfully",
                    style: Fonts.ubuntu(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: ColorPallete.blackColor),
                  ),
                ),
              );
              context.go('/home');
            }
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(20),
                backgroundColor: ColorPallete.logoutRedColor,
                content: Text(
                  state.message,
                  style: Fonts.ubuntu(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.whiteColor),
                ),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(flex: 2, child: SizedBox()),
                  Image.asset(
                    'assets/icons/iskcon_logo_bg.png',
                    // height: 96,
                    // width: 32,
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
                        fontSize: 18,
                        color: ColorPallete.blackColor,
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
                          fontSize: 18,
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
                          vertical: 14, horizontal: 40),
                      backgroundColor: ColorPallete.blueColor,
                      textStyle: const TextStyle(
                          color: Color.fromARGB(238, 255, 255, 255),
                          fontSize: 24,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () async {
                      BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                          emailController.text, passwordController.text));

                      //  BlocProvider.of<AuthBloc>(context).add(FetchProfileDataEvent());

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
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  TextButton(
                      onPressed: () {
                        context.go('/login/register');
                        // GoRouter.of(context)
                        //     .pushNamed(MyAppRouteConstants.registerRouteName);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Don’t have an account yet? ',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPallete.blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                color: ColorPallete.blueColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(flex: 2, child: SizedBox()),
                  Padding(padding: EdgeInsets.only(top: 10)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
