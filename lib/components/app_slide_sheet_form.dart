import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';

class AppSlideSheetForm extends StatefulWidget {
  final String title;
  final Widget form;
  const AppSlideSheetForm({Key? key, required this.title, required this.form})
      : super(key: key);

  @override
  State<AppSlideSheetForm> createState() => _AppSlideSheetFormState();
}

class _AppSlideSheetFormState extends State<AppSlideSheetForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontFamily: AppFont.font,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          widget.form,
        ],
      ),
    );
  }
}
