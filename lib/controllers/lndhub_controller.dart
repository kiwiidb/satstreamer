import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:satstreamer/models/connection.dart';
import 'package:satstreamer/models/invoice.dart';
import 'package:satstreamer/service/lndhub_service.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LNDhubController extends GetxController {
  final LNDHubService svc = Get.put((LNDHubService()));
  final TextEditingController connectionStringController =
      TextEditingController();
  final speaker = FlutterTts();
  final LocalStorage lndhubStorage = LocalStorage('lndhub_credentials');

  @override
  void onInit() async {
    await lndhubStorage.ready;
    var connection = fetchConnectionString();
    if (connection != null) {
      connectionStringController.text = connection["key"].toString();
    }
    super.onInit();
  }

  Future<void> setConnectionString() async {
    await lndhubStorage
        .setItem("connectionstring", {"key": connectionStringController.text});
  }

  dynamic fetchConnectionString() {
    return lndhubStorage.getItem("connectionstring");
  }

  void fetchToken() async {
    var connection = parseConnectionString(connectionStringController.text);
    await setConnectionString();

    var fetched = fetchConnectionString();
    svc.init(connection!.host!, connection.login!, connection.password!);
    await svc.fetchToken();
    var stream = svc.streamInvoices();
    stream.listen((event) {
      final InvoiceEvent payload = InvoiceEvent.fromJson(jsonDecode(event));

      if (payload.type == "keepalive") {
        print("keepalive");
        return;
      }
      if (payload.invoice == null) {
        return;
      }
      String description = payload.invoice!.description!;
      Get.snackbar("New payment", description.toString());
      speaker.setLanguage("en-US");
      speaker.speak(description.toString());
    });
  }

  //lndhub://user:pw@https://host.com
  Connection? parseConnectionString(String conn) {
    conn = conn.replaceFirst("lndhub://", "");
    var parts = conn.split("@");
    if (parts.length != 2) {
      throw Exception("LNDhub connection string invalid.");
    }
    var host = parts[1].replaceAll("https://", "");
    host = host.replaceAll("http://", "");
    var loginParts = parts[0].split(":");
    if (loginParts.length != 2) {
      throw Exception("LNDhub connection string invalid.");
    }
    return Connection(
        host: host, login: loginParts[0], password: loginParts[1]);
  }
}
