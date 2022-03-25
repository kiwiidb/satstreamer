import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lndhub_controller.dart';

class NewPaymentView extends StatelessWidget {
  const NewPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());
    return SizedBox(
      height: 500,
      width: 500,
      child: Obx((() {
        if (!c.receivedPayment.value) {
          return const Text("Waiting for payment...");
        } else {
          var payment = c.lastPayment.value.invoice!;
          var satvalue = payment.amt;
          var msg = payment.description!;
          return Column(
            children: [
              Text("New donation of $satvalue sats!"),
              const SizedBox(
                height: 10,
              ),
              Text(msg),
            ],
          );
        }
      })),
    );
  }
}
