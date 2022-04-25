import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satstreamer/views/ln_address.dart';
import 'package:satstreamer/views/webcam.dart';

import '../controllers/lndhub_controller.dart';
import 'control_panel.dart';
import 'history.dart';
import 'new_payment.dart';

class StreamView extends StatelessWidget {
  const StreamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());
    var host = c.host;
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: const [ControlPanel(), WebcamView()],
          ),
          Column(
            children: const [
              NewPaymentView(),
              AddressView(),
            ],
          ),
          const HistoryView()
        ]);
  }
}
