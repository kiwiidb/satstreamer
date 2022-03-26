import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:get/get.dart';

import '../controllers/lndhub_controller.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());
    return SizedBox(
        height: 600,
        width: 400,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Show media from image links in payment"),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              value: c.showMediaFromPayments.value,
                              onChanged: (bool? value) {
                                c.showMediaFromPayments.value = value!;
                                return;
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          (const Text("Auto-open links from payment")),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              value: c.autoOpenLinks.value,
                              onChanged: (bool? value) {
                                c.autoOpenLinks.value = value!;
                                return;
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Text to speech"),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              value: c.textToSpeech.value,
                              onChanged: (bool? value) {
                                c.textToSpeech.value = value!;
                                return;
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          (const Text("Voice language")),
                          const SizedBox(
                            width: 5,
                          ),
                          DropdownButton(items: const [
                            DropdownMenuItem(
                              child: Text("test"),
                            )
                          ], onChanged: (dynamic item) {})
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Voice volume"),
                          const SizedBox(
                            width: 5,
                          ),
                          ElegantNumberButton(
                            initialValue: 10,
                            minValue: 0,
                            maxValue: 10,
                            step: 0.5,
                            decimalPlaces: 1,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ]);
              }),
            )));
  }
}
