import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satstreamer/views/control_panel.dart';

import '../controllers/lndhub_controller.dart';

class WebcamView extends StatelessWidget {
  const WebcamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height - 60;
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      SizedBox(
          width: totalWidth,
          height: 0.9 * totalHeight,
          child: Obx((() {
            if (!c.cameraInitialized.value) {
              return Center(
                child: ElevatedButton(
                    onPressed: c.initCamera,
                    child: const Text("Grant webcam access")),
              );
            }
            return CameraPreview(c.cameraController);
          }))),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 50,
              width: 50,
              color: Colors.red,
              child: Text(c.lnAddressController.text)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "Settings", content: const ControlPanel());
                },
                child: const Icon(
                  Icons.settings,
                  size: 40,
                )),
          ),
        ],
      )
    ]);
  }
}
