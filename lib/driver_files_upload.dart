import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_input.dart';
import 'package:driver/components/screen_title.dart';
import 'package:flutter/material.dart';

class DriverFilesUploadScreen extends StatefulWidget {
  const DriverFilesUploadScreen({Key? key}) : super(key: key);

  @override
  State<DriverFilesUploadScreen> createState() =>
      _DriverFilesUploadScreenState();
}

class _DriverFilesUploadScreenState extends State<DriverFilesUploadScreen> {
  final TextEditingController cogExpiryController = TextEditingController();
  final TextEditingController cogFileController = TextEditingController();
  final TextEditingController dlNumberController = TextEditingController();
  final TextEditingController dlExpiryController = TextEditingController();
  final TextEditingController dlClassController = TextEditingController();
  final TextEditingController dlFileController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController idFileController = TextEditingController();
  final TextEditingController recommendationFileController =
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
              children: const [
                ScreenTitle(title: "Driver Files Upload"),
                SizedBox(
                  height: 40.0,
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
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: AppInput(
                          label: "CoG Expiry Date",
                          type: TextInputType.datetime,
                          isIcon: true,
                          icon: Icons.date_range_outlined,
                          controller: cogExpiryController,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 159, 159, 160),
                                  width: 2.0,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.file_copy_outlined,
                                  color: Color.fromARGB(255, 159, 159, 160),
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: AppInput(
                          label: "DL Expiry Date",
                          type: TextInputType.datetime,
                          isIcon: true,
                          icon: Icons.date_range_outlined,
                          controller: dlExpiryController,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 159, 159, 160),
                                  width: 2.0,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.file_copy_outlined,
                                  color: Color.fromARGB(255, 159, 159, 160),
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  AppInput(
                    label: "DL Number",
                    type: TextInputType.number,
                    isIcon: true,
                    icon: Icons.numbers_outlined,
                    controller: dlNumberController,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  AppInput(
                    label: "DL Class",
                    type: TextInputType.text,
                    isIcon: true,
                    icon: Icons.numbers_outlined,
                    controller: dlClassController,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: AppInput(
                          label: "ID Number",
                          type: TextInputType.number,
                          isIcon: true,
                          icon: Icons.person_outline,
                          controller: idNumberController,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 159, 159, 160),
                                  width: 2.0,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.file_copy_outlined,
                                  color: Color.fromARGB(255, 159, 159, 160),
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recommendation Letters (2 letters):",
                        style: TextStyle(
                          color: Color(0xff4e4e4e),
                          fontFamily: AppFont.font,
                          fontSize: 15.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: const Color.fromARGB(255, 159, 159, 160),
                              width: 2.0,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.file_copy_outlined,
                              color: Color.fromARGB(255, 159, 159, 160),
                              size: 30.0,
                            ),
                          ),
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
                            backgroundColor: AppColors.mainColor,
                            borderColor: AppColors.mainColor,
                            text: "Submit",
                            onClicked: () {}),
                      ),
                    ],
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
