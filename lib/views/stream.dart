import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Connected to $host"),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
                onPressed: c.disconnect, child: const Text("Disconnect")),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(
              width: 200,
            ),
            HistoryView(),
            SizedBox(
              width: 100,
            ),
            NewPaymentView(),
            ControlPanel(),
          ],
        ),
      ],
    );
  }
}
