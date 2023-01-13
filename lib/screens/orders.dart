import 'package:driver/components/app_search_input.dart';
import 'package:driver/components/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:driver/screens/orders/orders_table_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 30.0,
            ),
            ScreenTitle(title: "My Orders"),
            SizedBox(
              height: 15.0,
            ),
            SearchInput(),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: OrdersTableList(),
            ),
          ],
        ),
      ),
    );
  }
}
