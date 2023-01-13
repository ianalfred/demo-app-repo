import 'dart:convert';

import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/screen_title.dart';
import 'package:driver/login.dart';
import 'package:driver/screens/account_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  var driver = {};

  void getDriver() async {
    String? driverStore = await storage.read(key: "driver");

    setState(() {
      driver = jsonDecode(driverStore!);
    });
  }

  void logoutUser() async {
    await storage.deleteAll();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getDriver();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 188,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ScreenTitle(title: "My Profile"),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.notifications_outlined,
                            color: Colors.grey[600],
                            size: 29.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 42.0,
                              backgroundColor: AppColors.mainColor,
                              child: CircleAvatar(
                                radius: 38.0,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  driver["first_name"].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: AppFont.font,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(
                                  "user@email.com",
                                  style: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 14,
                                    fontFamily: AppFont.font,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AccountEdit()),
                            );
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.mainColor.withOpacity(0.1),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.edit,
                                color: AppColors.mainColor,
                                size: 27.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.person_pin_circle_outlined,
                            color: Color(0xff565656),
                            size: 26.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Allocated Depot:",
                            style: TextStyle(
                              color: Color(0xff565656),
                              fontSize: 15,
                              fontFamily: AppFont.font,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Deport Name",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppFont.font,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.local_shipping_outlined,
                            color: Color(0xff565656),
                            size: 26.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Vehicle Number:",
                            style: TextStyle(
                              color: Color(0xff565656),
                              fontSize: 15,
                              fontFamily: AppFont.font,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "KAA 123A",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppFont.font,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.person_outline_rounded,
                            color: Color(0xff565656),
                            size: 26.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Partner Name:",
                            style: TextStyle(
                              color: Color(0xff565656),
                              fontSize: 15,
                              fontFamily: AppFont.font,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "FirstName LastName",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppFont.font,
                          fontWeight: FontWeight.w600,
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
                      Expanded(
                        flex: 1,
                        child: AppButton(
                            textColor: Colors.white,
                            backgroundColor: AppColors.errorColor,
                            borderColor: AppColors.errorColor,
                            text: "Logout",
                            onClicked: () {
                              logoutUser();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            }),
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
