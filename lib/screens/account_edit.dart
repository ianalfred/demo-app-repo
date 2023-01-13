import 'dart:io';

import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_input.dart';
import 'package:driver/components/app_password_input.dart';
import 'package:driver/components/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AccountEdit extends StatefulWidget {
  const AccountEdit({Key? key}) : super(key: key);

  @override
  State<AccountEdit> createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController currentpasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  /// Image Gallery Selection
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final selectedImage = File(image.path);
      setState(() => this.image = selectedImage);
    } on PlatformException catch (e) {
      print("Failt to pick image $e");
    }
  }

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
                  const ScreenTitle(title: "Edit Profile"),
                  const SizedBox(
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
                    Center(
                      child: GestureDetector(
                        onTap: () => pickImage(ImageSource.gallery),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 55.0,
                              backgroundColor: AppColors.mainColor,
                              child: image != null
                                  ? ClipOval(
                                      child: Image.file(
                                        image!,
                                        width: 102.0,
                                        height: 102.0,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      radius: 51.0,
                                      backgroundImage: AssetImage(
                                          'assets/images/avatar.png'),
                                    ),
                            ),
                            Positioned(
                              right: 0.0,
                              top: 0.0,
                              child: Container(
                                padding: const EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.mainColor,
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                      label: "Current Password",
                      type: TextInputType.visiblePassword,
                      isIcon: true,
                      icon: Icons.lock_outline,
                      controller: currentpasswordController,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    AppPasswordInput(
                      label: "New Password",
                      type: TextInputType.visiblePassword,
                      isIcon: true,
                      icon: Icons.lock_outline,
                      controller: newPasswordController,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    AppPasswordInput(
                      label: "Confirm New Password",
                      type: TextInputType.visiblePassword,
                      isIcon: true,
                      icon: Icons.lock_outline,
                      controller: confirmNewPasswordController,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            textColor: AppColors.mainColor,
                            backgroundColor: Colors.white,
                            borderColor: AppColors.mainColor,
                            text: "Cancel",
                            onClicked: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: AppButton(
                            textColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            borderColor: AppColors.mainColor,
                            text: "Save",
                            onClicked: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
