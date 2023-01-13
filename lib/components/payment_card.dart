import 'package:driver/components/app_badge.dart';
import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatefulWidget {
  final int paymentNumber;
  final String vehicleRegistration;
  final int amount;
  final String date;
  final bool complete;
  const PaymentCard(
      {Key? key,
      required this.paymentNumber,
      required this.vehicleRegistration,
      required this.amount,
      required this.date,
      required this.complete})
      : super(key: key);

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
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
                  "Payment #${widget.paymentNumber}",
                  style: const TextStyle(
                    color: Color(0xff999999),
                    decoration: TextDecoration.underline,
                    fontSize: 12.0,
                    fontFamily: AppFont.font,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppBadge(isComplete: widget.complete),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 85.0,
                  child: Text(
                    "Vehicle Reg:",
                    style: TextStyle(
                      color: Color(0xff4e4e4e),
                      fontFamily: AppFont.font,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  widget.vehicleRegistration,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppFont.font,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 85.0,
                      child: Text(
                        "Amount:",
                        style: TextStyle(
                          color: Color(0xff4e4e4e),
                          fontFamily: AppFont.font,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      "Ksh. ${widget.amount}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppFont.font,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
