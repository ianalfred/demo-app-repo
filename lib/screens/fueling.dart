import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_input.dart';
import 'package:driver/components/app_slide_sheet_button.dart';
import 'package:driver/components/app_slide_sheet_form.dart';
import 'package:driver/components/screen_title.dart';
import 'package:driver/screens/mileage/mileage_table_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class FuelingScreen extends StatefulWidget {
  const FuelingScreen({Key? key}) : super(key: key);

  @override
  State<FuelingScreen> createState() => _FuelingScreenState();
}

class _FuelingScreenState extends State<FuelingScreen> {
  final TextEditingController milageController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String address = "";

  /// Image Gallery Selection
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final selectedImage = File(image.path);
      setState(() => this.image = selectedImage);
    } on PlatformException catch (e) {
      // print("Failt to pick image $e");
    }
  }

  void getStorage() async {
    String? addressStore = await storage.read(key: "address");

    setState(() {
      address = addressStore.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getStorage();
  }

  Widget fuelingForm() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppInput(
            label: "Enter the Milage",
            type: TextInputType.text,
            isIcon: true,
            icon: Icons.speed,
            controller: milageController,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Odometer image:",
            style: TextStyle(
              color: Color(0xff4e4e4e),
              fontFamily: AppFont.font,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          image != null
              ? Image.file(
                  image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                )
              : DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10.0),
                  dashPattern: const [10, 10],
                  color: const Color(0xff999999),
                  strokeWidth: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 57.0, horizontal: 60.0),
                    height: 160.0,
                    width: double.infinity,
                    child: Center(
                      child: AppButton(
                        textColor: AppColors.mainColor,
                        backgroundColor: Colors.transparent,
                        borderColor: AppColors.mainColor,
                        text: "Open Camera",
                        isIcon: true,
                        icon: Icons.camera_alt_outlined,
                        onClicked: () => pickImage(ImageSource.camera),
                      ),
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image != null
                  ? AppButton(
                      textColor: AppColors.mainColor,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.mainColor,
                      text: "Open Camera",
                      isIcon: true,
                      icon: Icons.camera_alt_outlined,
                      onClicked: () => pickImage(ImageSource.camera),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Location:",
            style: TextStyle(
              color: Color(0xff4e4e4e),
              fontFamily: AppFont.font,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 25.0,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppFont.font,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AppButton(
                    textColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    borderColor: AppColors.mainColor,
                    text: "SUBMIT",
                    onClicked: () {}),
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              const ScreenTitle(title: "Fueling"),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppSlideButton(
                            icon: Icons.play_circle_outline,
                            iconColor: AppColors.mainColor,
                            text: "Request Fuel",
                            backgroundColor: AppColors.mainColor,
                            borderColor: AppColors.mainColor,
                            size: 70.0,
                            onButtonSelected: () => showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => AppSlideSheetForm(
                                title: "Request Fuel",
                                form: fuelingForm(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 10,
              ),
              const Text(
                "List of Milage",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: AppFont.font,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const MileageTableListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
