import 'package:driver/components/app_search_input.dart';
import 'package:driver/components/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:driver/screens/payments/payments_table_list.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 30.0,
            ),
            ScreenTitle(title: "My Payments"),
            SizedBox(
              height: 15.0,
            ),
            SearchInput(),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: PaymentsTableList(),
            ),
          ],
        ),
      ),
    );
  }
}
