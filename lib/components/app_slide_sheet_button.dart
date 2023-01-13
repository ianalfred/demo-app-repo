import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';

class AppSlideButton extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final double size;
  final VoidCallback onButtonSelected;

  const AppSlideButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.backgroundColor,
    required this.borderColor,
    required this.size,
    required this.onButtonSelected,
  }) : super(key: key);

  @override
  State<AppSlideButton> createState() => _AppSlideButtonState();
}

class _AppSlideButtonState extends State<AppSlideButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => widget.onButtonSelected(),
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              color: widget.backgroundColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: widget.borderColor.withOpacity(0.3),
                width: 1.0,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3317c690),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                widget.icon,
                color: widget.iconColor,
                size: 40.0,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        Text(
          widget.text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontFamily: AppFont.font,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
