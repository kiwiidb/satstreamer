import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lndhub_controller.dart';

class WebcamView extends StatelessWidget {
  const WebcamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height - 60;
    return SizedBox(
        width: totalWidth / 3,
        height: totalHeight / 2,
        child: Obx((() {
          if (!c.cameraInitialized.value) {
            return Container();
          }
          return CameraPreview(c.cameraController);
        })));
  }
}
