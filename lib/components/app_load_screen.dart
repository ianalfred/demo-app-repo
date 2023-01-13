import 'package:driver/components/app_spinner.dart';
import 'package:driver/home.dart';
import 'package:flutter/material.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  late bool appBarVisible = true;

  void changeAppBarVisiblity(bool isVisible) {
    if (mounted) {
      setState(() {
        appBarVisible = isVisible;
      });
    }
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  onNavChange: (bool visible) {
                    changeAppBarVisiblity(true);
                  },
                )),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppSpinner(stroke: 2.0),
      ),
    );
  }
}
