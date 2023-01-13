import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 241.0,
                      height: 87,
                      child: Image.asset("assets/images/logo-no-space.png"),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 250.0,
                      height: 200.0,
                      child: SvgPicture.asset(
                        'assets/images/delivery_truck.svg',
                        semanticsLabel: "Dafric",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Logistic Solutions",
                    style: TextStyle(
                      color: Color(0xff1f2933),
                      fontSize: 24,
                      fontFamily: AppFont.font,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "We deliver a positive, reliable experience to each and every one of our clients as a trusted partner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff8a8a8e),
                      fontSize: 16,
                      fontFamily: AppFont.font,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AppButton(
                          textColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          borderColor: AppColors.mainColor,
                          text: "Get Started",
                          onClicked: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
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
    );
  }
}
