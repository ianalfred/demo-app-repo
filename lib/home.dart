import 'dart:convert';

import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_spinner.dart';
import 'package:driver/screens/account.dart';
import 'package:driver/screens/fueling.dart';
import 'package:driver/screens/mileage.dart';
import 'package:driver/screens/orders.dart';
import 'package:driver/screens/payments.dart';
import 'package:flutter/material.dart';
import 'package:driver/api/gql_strings.dart' as gql_string;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

typedef VoidCallback = void Function(bool val);

class HomeScreen extends StatefulWidget {
  final VoidCallback onNavChange;
  const HomeScreen({Key? key, required this.onNavChange}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  int selectedIndex = 0;

  var user = {};

  void getUser() async {
    String? userStore = await storage.read(key: "user");
    setState(() {
      user = jsonDecode(userStore!);
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const OrdersScreen();
    switch (selectedIndex) {
      case 0:
        currentWidgetPage = const OrdersScreen();
        break;
      case 1:
        currentWidgetPage = const MileageScreen();
        break;
      case 2:
        currentWidgetPage = const FuelingScreen();
        break;
      case 3:
        currentWidgetPage = const PaymentsScreen();
        break;
      case 4:
        currentWidgetPage = const AccountScreen();
        break;
    }
    return Query(
      options: QueryOptions(
        document: gql(gql_string.diverQuery),
        variables: {
          "id": user["id"].toString(),
        },
      ),
      builder: ((result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }
        if (result.data == null) {
          return const Scaffold(
            body: Center(
              child: AppSpinner(stroke: 2.0),
            ),
          );
        } else {
          final Map<String, dynamic> driver = result.data!["driver"];
          var driverStore = jsonEncode(driver);
          storage.write(key: "driver", value: driverStore);
          return Scaffold(
            bottomNavigationBar: Row(
              children: [
                navbarItem(Icons.shopping_cart_outlined, 0, "Orders", true),
                navbarItem(Icons.map_outlined, 1, "Mileage", true),
                navbarItem(
                    Icons.local_gas_station_outlined, 2, "Fueling", true),
                navbarItem(Icons.payments_outlined, 3, "Payments", true),
                navbarItem(Icons.person_outline, 4, "Account", false),
              ],
            ),
            body: currentWidgetPage,
          );
        }
      }),
    );
  }

  Widget navbarItem(IconData icon, int index, String label, bool visible) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        widget.onNavChange(visible);
      },
      child: Container(
        height: 76,
        width: MediaQuery.of(context).size.width / 5,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 34.0,
              color: index == selectedIndex
                  ? AppColors.mainColor
                  : const Color(0xff999999),
            ),
            Text(
              label,
              style: TextStyle(
                color: index == selectedIndex
                    ? AppColors.mainColor
                    : const Color(0xff999999),
                fontSize: 13,
                fontFamily: AppFont.font,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
