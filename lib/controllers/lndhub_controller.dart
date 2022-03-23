import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satstreamer/service/lndhub_service.dart';

class LNDhubController extends GetxController {
  final LNDHubService svc = Get.put((LNDHubService()));
  final TextEditingController connectionStringController =
      TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  void fetchToken() async {
    var login = loginController.text;
    var pw = pwController.text;
    svc.init(login, pw);
    await svc.fetchToken();
    await svc.fetchBalance();
  }
}
