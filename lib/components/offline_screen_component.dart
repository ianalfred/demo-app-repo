import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class OfflineScreen extends StatelessWidget {
  final VoidCallback onClicked;
  const OfflineScreen({Key? key, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                color: Colors.grey,
                size: 40.0,
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                "Offline. Turn on internet connection.",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: AppFont.font,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              GestureDetector(
                onTap: () => onClicked(),
                child: const Text(
                  "Refresh",
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontFamily: AppFont.font,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
