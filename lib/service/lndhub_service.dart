import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:satstreamer/models/balance.dart';
import 'package:satstreamer/models/lndhub_auth.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LNDHubService extends GetxService {
  String host;
  String login;
  String password;
  String accessToken;
  String refreshToken;
  LNDHubService({
    this.host = "",
    this.login = "",
    this.password = "",
    this.accessToken = "",
    this.refreshToken = "",
  });

  void init(String host, String login, String password) {
    this.login = login;
    this.password = password;
    this.host = host;
  }

  Future<void> fetchToken() async {
    var response = await http.post(
      Uri.https(host, '/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'login': login,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var payload = AuthResponse.fromJson(jsonDecode(response.body));
      accessToken = payload.accessToken!;
      refreshToken = payload.refreshToken!;
    } else {
      Get.snackbar(
          "Something went wrong fetching token", response.bodyBytes.toString(),
          snackPosition: SnackPosition.BOTTOM);
      throw Exception('Error fetching token');
    }
  }

  Future<void> fetchBalance() async {
    var response = await http.get(
      Uri.https(host, '/balance'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var payload = BalanceResponse.fromJson(jsonDecode(response.body));
      Get.snackbar("Balance", payload.bTC!.availableBalance.toString());
    } else {
      Get.snackbar("Something went wrong fetching balance",
          response.bodyBytes.toString(),
          snackPosition: SnackPosition.BOTTOM);
      throw Exception('Error fetching balance');
    }
  }

  Stream<dynamic> streamInvoices() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://$host/invoices/stream?token=$accessToken'),
    );
    return channel.stream;
  }
}
