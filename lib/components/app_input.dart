import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';

// typedef void StringCallback(String text);

class AppInput extends StatefulWidget {
  final String label;
  final dynamic type;
  final bool isIcon;
  final IconData? icon;
  final TextEditingController controller;
  final bool isValidated;
  final FormFieldValidator? validator;
  const AppInput({
    Key? key,
    required this.label,
    this.isIcon = false,
    this.icon,
    required this.type,
    required this.controller,
    this.isValidated = false,
    this.validator,
  }) : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  Widget inputIcon() {
    return widget.isIcon == false ? const Icon(null) : Icon(widget.icon);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      validator:
          widget.isValidated == true ? widget.validator : (value) => null,
      style: const TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: AppFont.font,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: Color(0xff979797),
          fontSize: 17.0,
          fontFamily: AppFont.font,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xffb9b9bb),
          ),
        ),
        prefixIcon: inputIcon(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.mainColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
