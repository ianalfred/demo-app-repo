import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:driver/components/app_button.dart';
import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_input.dart';
import 'package:driver/components/app_slide_sheet_button.dart';
import 'package:driver/components/app_slide_sheet_form.dart';
import 'package:driver/components/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:driver/screens/mileage/mileage_table_list.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:driver/api/gql_strings.dart' as gql_string;

class MileageScreen extends StatefulWidget {
  const MileageScreen({Key? key}) : super(key: key);

  @override
  State<MileageScreen> createState() => _MileageScreenState();
}

class _MileageScreenState extends State<MileageScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController milageController = TextEditingController();

  bool isEndTrip = false;
  bool isLoading = false;

  late bool inputErrors = false;
  String errorMessage = "";

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  var driver = {};
  String location = "";
  var mileage = {};

  /// Image Gallery Selection
  File? image;
  bool isFileSubmissionNull = false;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final selectedImage = File(image.path);
      setState(() => this.image = File(image.path));
    } on PlatformException catch (e) {
      print("Failt to pick image $e");
    }
  }

  /// Retrieve driver and coordinates for trips form
  void getStorage() async {
    String? milageStore = await storage.read(key: "mileage");
    String? driverStore = await storage.read(key: "driver");
    String? locationStore = await storage.read(key: "coordinates");
    setState(() {
      driver = jsonDecode(driverStore!);
      location = locationStore.toString();
      if (milageStore != null) {
        mileage = jsonDecode(milageStore);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getStorage();
  }

  @override
  void dispose() {
    super.dispose();
    milageController.dispose();
  }

  /// Trips form
  Widget milageForm() => Mutation(
      options: MutationOptions(
        document: isEndTrip == false
            ? gql(gql_string.startTripMutation)
            : gql(gql_string.endTripMutation),
        // ignore: void_checks
        update: (cache, result) {
          // if (result!.hasException) {
          //   inputErrors = true;
          //   errorMessage = result.exception.toString();
          // } else {
          //   return cache;
          // }
          var message = result!.hasException
              ? result.exception.toString()
              : "Successful request made";
          final snackBar = SnackBar(content: Text(message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(message);
        },
        onError: (dynamic error) {
          setState(() {
            inputErrors = true;
            errorMessage = error.toString();
            isLoading = false;
          });
        },
        onCompleted: (dynamic data) {
          Navigator.of(context).pop();
          if (data != null && isEndTrip == false) {
            setState(() {
              image = null;
              isLoading = false;
              milageController.clear();
            });
            var mileage = jsonEncode(data["createMileage"]["mileage"]);
            storage.write(key: "mileage", value: mileage);
          } else if (data != null) {
            setState(() {
              image = null;
              isLoading = false;
              isEndTrip = false;
              milageController.clear();
            });
            mileage = {};
            storage.delete(key: "mileage");
          }
        },
      ),
      builder: ((runMutation, result) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppInput(
                label: "Enter the Milage",
                type: const TextInputType.numberWithOptions(decimal: true),
                isIcon: true,
                icon: Icons.speed,
                controller: milageController,
                isValidated: true,
                validator: (value) {
                  if (value == null) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                },
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
                  ? Center(
                      child: Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
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
                            onClicked: () {
                              pickImage(ImageSource.camera);
                              setState(() {
                                isFileSubmissionNull = false;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isFileSubmissionNull == true
                      ? const Text(
                          "Odometer image reqired",
                          style: TextStyle(
                            color: AppColors.errorColor,
                            fontFamily: AppFont.font,
                            fontSize: 13.0,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
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
                height: 10,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: (isEndTrip == false && mileage != {})
                        ? AppButton(
                            textColor: Colors.white,
                            backgroundColor: isLoading == false
                                ? AppColors.mainColor
                                : AppColors.mainColor.withOpacity(0.2),
                            borderColor: isLoading == false
                                ? AppColors.mainColor
                                : AppColors.mainColor.withOpacity(0.1),
                            text: "SUBMIT",
                            onClicked: () {
                              final isValidForm =
                                  formKey.currentState!.validate();
                              var byteData = image?.readAsBytesSync();

                              var multipartOpeningFile =
                                  MultipartFile.fromBytes(
                                'photo',
                                byteData!,
                                filename: '${DateTime.now().second}.jpg',
                                contentType: MediaType("image", "jpg"),
                              );
                              var multipartClosingFile =
                                  MultipartFile.fromBytes(
                                'photo',
                                byteData,
                                filename: '${DateTime.now().second}.jpg',
                                contentType: MediaType("image", "jpg"),
                              );
                              if (image == null) {
                                setState(() {
                                  isFileSubmissionNull = true;
                                });
                              }
                              if (isValidForm) {
                                setState(() {
                                  isLoading = true;
                                });
                                isEndTrip == false
                                    ? runMutation({
                                        'opening_mileage':
                                            double.parse(milageController.text),
                                        'closing_mileage': 0.0,
                                        'opening_date':
                                            DateTime.now().toString(),
                                        'closing_date': "pending",
                                        'opening_file': multipartOpeningFile,
                                        'closing_file': multipartClosingFile,
                                        // ignore: unnecessary_string_interpolations
                                        'opening_geo_points': "$location",
                                        'closing_geo_points': "pending",
                                        'vehicle_id': int.parse(
                                            driver["assignment"]["vehicle"]
                                                ["id"]),
                                        'driver_id': int.parse(driver["id"]),
                                      })
                                    : runMutation({
                                        'id': int.parse(mileage["id"]),
                                        'closing_mileage':
                                            milageController.text,
                                        'closing_date': DateTime.parse(
                                                DateTime.now().toString())
                                            .toLocal(),
                                        'closing_file': multipartClosingFile,
                                        // ignore: unnecessary_string_interpolations
                                        'closing_geo_points': "$location",
                                      });
                              }
                            })
                        : Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: AppColors.mainColor.withOpacity(0.1),
                                width: 2.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mainColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                  fontFamily: AppFont.font,
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      }));

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
              const ScreenTitle(title: "Mileage"),
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
                            text: "Start Trip",
                            backgroundColor: AppColors.mainColor,
                            borderColor: AppColors.mainColor,
                            size: 70.0,
                            onButtonSelected: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) => AppSlideSheetForm(
                                  title: "Start Trip",
                                  form: milageForm(),
                                ),
                              );
                              setState(() {
                                isEndTrip = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppSlideButton(
                            icon: Icons.stop_circle_outlined,
                            iconColor: AppColors.mainColor,
                            text: "End Trip",
                            backgroundColor: AppColors.mainColor,
                            borderColor: AppColors.mainColor,
                            size: 70.0,
                            onButtonSelected: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) => AppSlideSheetForm(
                                  title: "End Trip",
                                  form: milageForm(),
                                ),
                              );
                              if (mileage == null) {
                                const snackBar = SnackBar(
                                  content: Text(
                                    " You need to first start a trip",
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              setState(() {
                                isEndTrip = true;
                              });
                            },
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
