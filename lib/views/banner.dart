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
      var msg = "Waiting for payment...";
      if (c.receivedPayment.value) {
        var payment = c.lastPayment.value.invoice!;
        msg = payment.description!;
      }
      return Container(
        color: Colors.purple,
        child: SizedBox(
            width: totalWidth,
            height: 0.1 * totalHeight,
            child: Marquee(
              style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 60)),
              text: msg,
            )),
      );
    });
  }
}
