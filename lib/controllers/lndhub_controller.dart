import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bech32/bech32.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:satstreamer/controllers/home_controller.dart';
import 'package:satstreamer/models/connection.dart';
import 'package:satstreamer/models/invoice.dart';
import 'package:satstreamer/service/lndhub_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';
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
  var highestPayment = InvoiceEvent().obs;
  var paymentHistory = <InvoiceEvent>[].obs;
  var receivedPayment = false.obs;
  var showMediaFromPayments = false.obs;
  var showWebCam = false.obs;
  var showHighest = false.obs;
  var autoOpenLinks = false.obs;
  var textToSpeech = true.obs;
  var volume = 10.obs;
  var language = "en-US".obs;
  var languages = <String>[].obs;
  final TextEditingController placeholderText = TextEditingController();
  final TextEditingController lnAddressController = TextEditingController();
  var lnAddress = "you@getalby.com".obs;
  var placeholder =
      "⚡ 💸 Lightning donations: your message will show up here".obs;
  late CameraController cameraController;
  var cameraInitialized = false.obs;
  var showDefaultMsg = false.obs;

  @override
  void onInit() async {
    await lndhubStorage.ready;
    var connection = fetchConnectionString();
    if (connection != null) {
      connectionStringController.text = connection["key"].toString();
    }
    var lightningAddress = fetchLNAddress();
    if (lightningAddress != null) {
      lnAddressController.text = lightningAddress["key"].toString();
      lnAddress.value = lightningAddress["key"].toString();
    }
    var langs = await speaker.getLanguages;
    languages = RxList(langs);
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      showDefaultMsg.value = true;
    });
    placeholderText.text = placeholder.value;
    super.onInit();
  }

  void initCamera() async {
    var cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController.initialize();
    cameraInitialized.value = true;
  }

  void disableCamera() async {
    cameraInitialized.value = false;
    await cameraController.dispose();
  }

  String getRandomGif() {
    var gifs = [
      'images/baby.gif',
      'images/leo.gif',
      'images/lightning.gif',
      'images/margot.gif',
      'images/octo.gif',
      'images/rich.gif',
      'images/vince.gif',
    ];
    final _random = Random();
    return gifs[_random.nextInt(gifs.length)];
  }

  Future<void> setConnectionString() async {
    await lndhubStorage
        .setItem("connectionstring", {"key": connectionStringController.text});
  }

  dynamic fetchConnectionString() {
    return lndhubStorage.getItem("connectionstring");
  }

  Future<void> setLNAddress() async {
    await lndhubStorage.setItem("lnaddress", {"key": lnAddressController.text});
  }

  dynamic fetchLNAddress() {
    return lndhubStorage.getItem("lnaddress");
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
      getHighestPayment();
      String description = payload.invoice!.description!;
      if (!textToSpeech.value) {
        return;
      }
      speaker.setVolume(volume.value / 10);
      speaker.setLanguage(language.value);
      speaker.speak(description.toString());
      if (autoOpenLinks.value &&
          description.toString().startsWith("https://") &&
          !description.toString().isImageFileName) {
        launch(description.toString());
      }
    });
    //addMockpayment();
  }

  void getHighestPayment() {
    if (paymentHistory.isEmpty) {
      return;
    }
    highestPayment.value = paymentHistory[0];
    for (InvoiceEvent p in paymentHistory) {
      if (p.invoice!.amt! > highestPayment.value.invoice!.amt!) {
        highestPayment.value = p;
      }
    }
  }

  void addMockPayment() {
    //debugging
    receivedPayment.value = true;
    var mock = InvoiceEvent(
        type: "invoice",
        invoice: InvoiceResponse(
            amt: 1000,
            description:
                "mocking payment description need a long text here. hello hellohellohellohellohellohellohellohellohello"));
    lastPayment.value = mock;
    paymentHistory.add(mock);
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

  /// Converts a list of character positions in the bech32 alphabet ("words")
  /// to binary data.
  List<int> convertBech32(List<int> words) {
    final res = convert(words, 8, 5, true);
    return res;
  }

  /// Taken from bech32 (bitcoinjs): https://github.com/bitcoinjs/bech32
  List<int> convert(List<int> data, int inBits, int outBits, bool pad) {
    var value = 0;
    var bits = 0;
    var maxV = (1 << outBits) - 1;

    var result = <int>[];
    for (var i = 0; i < data.length; ++i) {
      value = (value << inBits) | data[i];
      bits += inBits;

      while (bits >= outBits) {
        bits -= outBits;
        result.add((value >> bits) & maxV);
      }
    }

    if (pad) {
      if (bits > 0) {
        result.add((value << (outBits - bits)) & maxV);
      }
    } else {
      if (bits >= inBits) {
        throw Exception('Excess padding');
      }

      if ((value << (outBits - bits)) & maxV > 0) {
        throw Exception('Non-zero padding');
      }
    }

    return result;
  }
}
