import 'package:driver/components/app_color.dart';
import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  final double stroke;
  const AppSpinner({Key? key, required this.stroke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.mainColor,
      strokeWidth: stroke,
    );
  }
}
