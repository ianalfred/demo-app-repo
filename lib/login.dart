import 'dart:convert';

import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_input.dart';
import 'package:driver/components/app_load_screen.dart';
import 'package:driver/components/app_password_input.dart';
import 'package:driver/components/screen_title.dart';
import 'package:driver/api/gql_strings.dart' as gql_string;
import 'package:driver/forgot-password.dart';
import 'package:driver/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late bool appBarVisible = true;

  late bool inputErrors = false;
  late String errorMessage;
  bool isLoading = false;

  void changeAppBarVisiblity(bool isVisible) {
    if (mounted) {
      setState(() {
        appBarVisible = isVisible;
      });
    }
  }

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.chevron_left_rounded,
                          color: Color(0xff595959),
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                            color: Color(0xff595959),
                            fontSize: 17,
                            fontFamily: AppFont.font,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 241.0,
                        height: 87,
                        child: Image.asset("assets/images/logo-no-space.png"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ScreenTitle(title: "Login"),
                      const SizedBox(
                        height: 20.0,
                      ),
                      inputErrors == true
                          ? Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: AppColors.errorColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Text(
                                "Username or Password was incorrect!",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontFamily: AppFont.font,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: Mutation(
                          options: MutationOptions(
                              document: gql(gql_string.loginUserMutation),
                              // ignore: void_checks
                              update: (cache, result) {
                                if (result!.hasException) {
                                  inputErrors = true;
                                  errorMessage = result.exception.toString();
                                } else {
                                  return cache;
                                }
                              },
                              onError: (dynamic error) {
                                setState(() {
                                  inputErrors = true;
                                  errorMessage = error.toString();
                                  isLoading = false;
                                });
                              },
                              // ignore: void_checks
                              onCompleted: (dynamic data) async {
                                setState(() {
                                  isLoading = false;
                                });
                                if (data == null) {
                                  setState(() {
                                    inputErrors = true;
                                  });
                                } else {
                                  await storage.write(
                                      key: "token",
                                      value:
                                          data["loginUser"]["token"] as String);
                                  var userStore =
                                      jsonEncode(data["loginUser"]["user"]);
                                  await storage.write(
                                      key: "user", value: userStore);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return Future.delayed(
                                      const Duration(milliseconds: 1500),
                                      () => Phoenix.rebirth(context));
                                }
                              }),
                          builder: ((runMutation, result) {
                            return ListView(
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                AppInput(
                                  label: "Email Address or Phone Number",
                                  type: TextInputType.emailAddress,
                                  isIcon: true,
                                  icon: Icons.email_outlined,
                                  controller: usernameController,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                AppPasswordInput(
                                  label: "Password",
                                  type: TextInputType.visiblePassword,
                                  isIcon: true,
                                  icon: Icons.lock_outline,
                                  controller: passwordController,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xff1f2933),
                                      fontSize: 12,
                                      fontFamily: AppFont.font,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: AppButton(
                                          textColor: Colors.white,
                                          backgroundColor: isLoading == false
                                              ? AppColors.mainColor
                                              : AppColors.mainColor
                                                  .withOpacity(0.2),
                                          borderColor: isLoading == false
                                              ? AppColors.mainColor
                                              : AppColors.mainColor
                                                  .withOpacity(0.1),
                                          text: "Login",
                                          onClicked: () {
                                            isLoading = true;
                                            runMutation({
                                              'username':
                                                  usernameController.text,
                                              'password':
                                                  passwordController.text,
                                            });
                                          },
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Dont have an account? ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: AppFont.font,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistrationScreen()),
                                        );
                                      }),
                                      child: const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.0,
                                          fontFamily: AppFont.font,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
