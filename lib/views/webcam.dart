import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lndhub_controller.dart';

class WebcamView extends StatelessWidget {
  const WebcamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());
    return SizedBox(
        height: 300,
        width: 400,
        child: Obx((() {
          if (!c.cameraInitialized.value) {
            return Container();
          }
          return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CameraPreview(c.cameraController));
        })));
  }
}
