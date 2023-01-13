import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_input.dart';
import 'package:driver/login.dart';
import 'package:driver/registration.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Forgot Driver App Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: AppFont.font,
                    fontWeight: FontWeight.w700,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                AppInput(
                  label: "Enter Email or Phone Number",
                  type: TextInputType.emailAddress,
                  isIcon: true,
                  icon: Icons.email_outlined,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Login?",
                        style: TextStyle(
                          fontFamily: AppFont.font,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppButton(
                        textColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        borderColor: AppColors.mainColor,
                        text: "RESET",
                        onClicked: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontFamily: AppFont.font,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()),
                        );
                      },
                      child: const Text(
                        "Register Account",
                        style: TextStyle(
                          fontFamily: AppFont.font,
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
    );
  }
}
