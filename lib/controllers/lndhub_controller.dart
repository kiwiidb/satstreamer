import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:satstreamer/controllers/home_controller.dart';
import 'package:satstreamer/models/connection.dart';
import 'package:satstreamer/models/invoice.dart';
import 'package:satstreamer/service/lndhub_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LNDhubController extends GetxController {
  final HomeController hc = Get.put(HomeController());
  final LNDHubService svc = Get.put((LNDHubService()));
  final TextEditingController connectionStringController =
      TextEditingController();
  final speaker = FlutterTts();
  final LocalStorage lndhubStorage = LocalStorage('lndhub_credentials');
  var host = "".obs;
  late WebSocketChannel channel;
  var lastPayment = InvoiceEvent().obs;
  var paymentHistory = <InvoiceEvent>[].obs;
  var receivedPayment = false.obs;

  @override
  void onInit() async {
    await lndhubStorage.ready;
    var connection = fetchConnectionString();
    if (connection != null) {
      connectionStringController.text = connection["key"].toString();
    }
    super.onInit();
  }

  String getRandomGif() {
    var gifs = [
      'images/baby.gif',
      'images/leo-laser.gif',
      'images/leo.gif',
      'images/lightning.gif',
      'images/margot.gif',
      'images/octo.gif',
      'images/rich.gif',
      'images/spongebob.gif',
      'images/vince.gif',
    ];
    final _random = new Random();
    return gifs[_random.nextInt(gifs.length)];
  }

  Future<void> setConnectionString() async {
    await lndhubStorage
        .setItem("connectionstring", {"key": connectionStringController.text});
  }

  dynamic fetchConnectionString() {
    return lndhubStorage.getItem("connectionstring");
  }

  void disconnect() async {
    await channel.sink.close();
    hc.setTab(0);
  }

  void fetchTokenAndStartStream() async {
    var connection = parseConnectionString(connectionStringController.text);
    if (connection == null ||
        connection.host == null ||
        connection.login == null ||
        connection.password == null) {
      Get.snackbar("Wrong connection string",
          "Make sure your connection string has the righ format.");
      return;
    }

    host.value = connection.host!;
    await setConnectionString();
    fetchConnectionString();

    svc.init(connection.host!, connection.login!, connection.password!);
    await svc.fetchToken();
    var channel = svc.streamInvoices();
    this.channel = channel;
    hc.setTab(1);
    channel.stream.listen((event) {
      final InvoiceEvent payload = InvoiceEvent.fromJson(jsonDecode(event));

      if (payload.type == "keepalive") {
        return;
      }
      if (payload.invoice == null) {
        return;
      }
      lastPayment.value = payload;
      receivedPayment.value = true;
      paymentHistory.add(payload);
      String description = payload.invoice!.description!;
      Get.snackbar("New payment", description.toString());
      speaker.setLanguage("en-US");
      speaker.speak(description.toString());
    });
    //debugging
    receivedPayment.value = true;
    lastPayment.value = InvoiceEvent(
        type: "invoice",
        invoice: InvoiceResponse(
            amt: 1000,
            description:
                "mocking payment description need a long text here. hello hellohellohellohellohellohellohellohellohello"));
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
