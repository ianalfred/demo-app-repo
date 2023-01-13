import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/app_spinner.dart';
import 'package:driver/components/payment_card.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PaymentsTableList extends StatefulWidget {
  const PaymentsTableList({Key? key}) : super(key: key);

  @override
  State<PaymentsTableList> createState() => _PaymentsTableListState();
}

class _PaymentsTableListState extends State<PaymentsTableList> {
  final ScrollController scrollController = ScrollController();
  List payments = [];
  List completePayments = [];
  List pendingPayments = [];
  bool loading = false;
  bool allLoaded = false;

  mockFetch() async {
    if (allLoaded) {
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    List<Map<String, dynamic>> data = payments.length >= 30
        ? []
        : List.generate(
            10,
            (index) => {
                  "payment": Random().nextInt(100),
                  "amount": Random().nextInt(1000),
                  "date": "$index-2-2020",
                  "vehicleReg": "KAA 123A",
                  "status": Random().nextBool(),
                });
    if (data.isNotEmpty) {
      payments.addAll(data);
      completePayments =
          payments.where((element) => element["status"] == true).toList();
      pendingPayments =
          payments.where((element) => element["status"] == false).toList();
    }

    setState(() {
      loading = false;
      allLoaded = data.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    mockFetch();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading) {
        mockFetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (payments.isNotEmpty) {
      return Stack(
        children: [
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 35.0,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.black.withOpacity(0.4),
                        indicator: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        tabs: [
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                    fontFamily: AppFont.font,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Complete",
                                  style: TextStyle(
                                    fontFamily: AppFont.font,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Pending",
                                  style: TextStyle(
                                    fontFamily: AppFont.font,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      tabView(payments),
                      tabView(completePayments),
                      tabView(pendingPayments),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (loading) ...[
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 15.0),
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      children: const [
                        SizedBox(
                          height: 25.0,
                          width: 25.0,
                          child: AppSpinner(
                            stroke: 2.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Loading more...",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: AppFont.font,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: AppSpinner(
            stroke: 3.0,
          ),
        ),
      );
    }
  }

  ListView tabView(List list) {
    return ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < list.length) {
          return PaymentCard(
            paymentNumber: list[index]['payment'],
            vehicleRegistration: list[index]['vehicleReg'].toString(),
            amount: list[index]['amount'],
            date: list[index]['date'].toString(),
            complete: list[index]["status"],
          );
        } else {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: const Center(
              child: Text(
                "All payments loaded.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontFamily: AppFont.font,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 6.0,
        );
      },
      itemCount: list.length + (allLoaded ? 1 : 0),
    );
  }
}
