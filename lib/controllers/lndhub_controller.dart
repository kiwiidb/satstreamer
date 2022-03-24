import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satstreamer/models/connection.dart';
import 'package:satstreamer/models/invoice.dart';
import 'package:satstreamer/service/lndhub_service.dart';

class LNDhubController extends GetxController {
  final LNDHubService svc = Get.put((LNDHubService()));
  final TextEditingController connectionStringController =
      TextEditingController();

  void fetchToken() async {
    var connection = parseConnectionString(connectionStringController.text);
    svc.init(connection!.host!, connection.login!, connection.password!);
    await svc.fetchToken();
    var stream = svc.streamInvoices();
    stream.listen((event) {
      var payload = InvoiceResponse.fromJson(jsonDecode(event));
      Get.snackbar("New payment", payload.description.toString());
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
