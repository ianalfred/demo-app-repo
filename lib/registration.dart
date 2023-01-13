import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_input.dart';
import 'package:driver/components/app_password_input.dart';
import 'package:flutter/material.dart';
import 'package:driver/login.dart';

import 'components/screen_title.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  const ScreenTitle(title: "Register"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 25.0,
                        ),
                        AppInput(
                          label: "First Name",
                          type: TextInputType.text,
                          isIcon: true,
                          icon: Icons.person_outline,
                          controller: firstNameController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        AppInput(
                          label: "Last Name",
                          type: TextInputType.text,
                          isIcon: true,
                          icon: Icons.person_outline,
                          controller: lastNameController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        AppInput(
                          label: "Email Address",
                          type: TextInputType.emailAddress,
                          isIcon: true,
                          icon: Icons.email_outlined,
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        AppInput(
                          label: "Phone Number",
                          type: TextInputType.phone,
                          isIcon: true,
                          icon: Icons.phone_outlined,
                          controller: phoneNumberController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        AppInput(
                          label: "Vehicle Number",
                          type: TextInputType.text,
                          isIcon: true,
                          icon: Icons.local_shipping_outlined,
                          controller: vehicleNumberController,
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
                        AppPasswordInput(
                          label: "Confirm Password",
                          type: TextInputType.visiblePassword,
                          isIcon: true,
                          icon: Icons.lock_outline,
                          controller: confirmPasswordController,
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
                                backgroundColor: AppColors.mainColor,
                                borderColor: AppColors.mainColor,
                                text: "Sign Up",
                                onClicked: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Have an account? ",
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
                                          const LoginScreen()),
                                );
                              }),
                              child: const Text(
                                "Login",
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
