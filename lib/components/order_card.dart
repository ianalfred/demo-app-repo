import 'package:driver/components/app_badge.dart';
import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  final int orderNumber;
  final String clientName;
  final String date;
  bool complete;
  OrderCard(
      {Key? key,
      required this.orderNumber,
      required this.clientName,
      required this.date,
      required this.complete})
      : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0c333333),
            blurRadius: 54.0,
            offset: Offset(15.0, 24.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order #${widget.orderNumber}",
                  style: const TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12.0,
                    fontFamily: AppFont.font,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppBadge(isComplete: widget.complete),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.clientName,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 14.0,
                    fontFamily: AppFont.font,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.date,
                  style: const TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12.0,
                    fontFamily: AppFont.font,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
