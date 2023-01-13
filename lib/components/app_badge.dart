import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  final bool isComplete;
  const AppBadge({Key? key, required this.isComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isComplete == true
            ? AppColors.mainColor.withOpacity(0.20)
            : AppColors.warningColor.withOpacity(0.20),
      ),
      child: Text(
        isComplete == true ? "Complete" : "Pending",
        style: TextStyle(
          color: isComplete == true
              ? AppColors.successColor
              : AppColors.warningColor,
          fontSize: 10.0,
          fontFamily: AppFont.font,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
