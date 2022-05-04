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
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height - 60;
    return SizedBox(
        width: totalWidth / 3,
        height: totalHeight / 2,
        child: Obx(() {
          var items = <DropdownMenuItem<String>>[];
          for (dynamic type in c.languages) {
            items.add(DropdownMenuItem(
                value: type as String?, child: Text(type as String)));
          }
          var host = c.host;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Connected to: "),
                            Text("$host"),
                            TextButton(
                                onPressed: c.disconnect,
                                child: const Text("Disconnect")),
                          ],
                        )),
                    Row(
                      children: [
                        const Text("Voice language: "),
                        const SizedBox(width: 5),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                              isDense: true,
                              elevation: 0,
                              value: c.language.value,
                              items: items,
                              onChanged: (dynamic item) async {
                                c.language.value = item;
                              }),
                        ),
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
                          color: Colors.transparent,
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
                    Row(
                      children: [
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
                        const Text("Show webcam"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.purple,
                            value: c.autoOpenLinks.value,
                            onChanged: (bool? value) {
                              c.autoOpenLinks.value = value!;
                              return;
                            }),
                        const Text("Auto-open links from payment"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.purple,
                            value: c.textToSpeech.value,
                            onChanged: (bool? value) async {
                              c.textToSpeech.value = value!;
                              return;
                            }),
                        const Text("Text to speech"),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: c.lnAddressController,
                          style: const TextStyle(color: Colors.purple),
                          onChanged: (String value) {
                            c.lnAddress.value = value;
                            c.setLNAddress();
                          },
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.purple),
                            labelText: "Lightning Address",
                            labelStyle: TextStyle(color: Colors.purple),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: c.placeholderText,
                          onChanged: (String value) {
                            c.placeholder.value = value;
                          },
                          style: const TextStyle(color: Colors.purple),
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.purple),
                            labelText: "Placeholder text",
                            labelStyle: TextStyle(color: Colors.purple),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                          ),
                        )),
                  ]),
            ),
          );
        }));
  }
}
