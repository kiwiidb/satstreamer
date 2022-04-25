import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/lndhub_controller.dart';

class AddressView extends StatelessWidget {
  const AddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());

    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height - 60;
    return SizedBox(
      width: totalWidth / 3,
      height: totalHeight / 2,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: c.lnAddressController,
            onChanged: (String? value) {
              c.setLNURL();
            },
            style: const TextStyle(color: Colors.purple, fontSize: 23),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none),
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
      ]),
    );
  }
}
