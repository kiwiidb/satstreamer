import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
                var items = <DropdownMenuItem<String>>[];
                for (dynamic type in c.languages) {
                  items.add(DropdownMenuItem(
                      value: type as String?, child: Text(type as String)));
                }
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Show webcam"),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              value: c.showWebCam.value,
                              activeColor: Colors.purple,
                              onChanged: (bool? value) {
                                c.showWebCam.value = value!;
                                if (value) {
                                  c.initCamera();
                                  return;
                                }
                                c.disableCamera();
                                return;
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Show highest donation instead of latest"),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              value: c.showHighest.value,
                              activeColor: Colors.purple,
                              onChanged: (bool? value) {
                                c.showHighest.value = value!;
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                              "Show media from .jpg/.png/.gif links in payment"),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              value: c.showMediaFromPayments.value,
                              activeColor: Colors.purple,
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
                              activeColor: Colors.purple,
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
                              activeColor: Colors.purple,
                              value: c.textToSpeech.value,
                              onChanged: (bool? value) async {
                                c.textToSpeech.value = value!;
                                return;
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          (const Text("Voice language")),
                          const SizedBox(
                            width: 5,
                          ),
                          DropdownButton(
                              value: c.language.value,
                              items: items,
                              onChanged: (dynamic item) async {
                                c.language.value = item;
                              })
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          const Text("Voice volume"),
                          const SizedBox(
                            width: 5,
                          ),
                          ElegantNumberButton(
                            color: Colors.purple,
                            initialValue: c.volume.value,
                            minValue: 0,
                            maxValue: 10,
                            step: 1,
                            decimalPlaces: 1,
                            buttonSizeHeight: 30,
                            buttonSizeWidth: 50,
                            onChanged: (value) {
                              c.volume.value = value.toInt();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: c.lnAddressController,
                          onChanged: (String? value) {
                            c.setLNURL();
                          },
                          style: const TextStyle(color: Colors.purple),
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.purple),
                            labelText: "LN Address",
                            labelStyle: TextStyle(color: Colors.purple),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => QrImage(
                              data: c.lnurl.value,
                              size: 200.0,
                            ),
                          ),
                        ),
                      ),
                    ]);
              }),
            )));
  }
}
