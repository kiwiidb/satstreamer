import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../controllers/lndhub_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBanner extends StatelessWidget {
  const MessageBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height - 60;
    return GetX<LNDhubController>(builder: (c) {
      var msg = c.placeholder.value;
      if (c.receivedPayment.value) {
        var paymentDescription = c.lastPayment.value.invoice!.description!;
        var amt = c.lastPayment.value.invoice!.amt!;
        msg = "💸 $amt sat: $paymentDescription";
      }
      return Container(
        color: Colors.white,
        child: SizedBox(
            width: totalWidth,
            height: 0.1 * totalHeight,
            child: Marquee(
              blankSpace: 300,
              velocity: 60,
              style: GoogleFonts.roboto(
                  textStyle:
                      const TextStyle(fontSize: 60, color: Colors.purple)),
              text: msg,
            )),
      );
    });
  }
}
