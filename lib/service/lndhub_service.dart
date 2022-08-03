import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:satstreamer/models/lndhub_auth.dart';

class LNDHubService extends GetxService {
  String host;
  String accessToken;
  String refreshToken;
  String clientId;
  String clientSecret;
  String redirectUri;
  String scopes;
  String authorizationHost;
  LNDHubService({
    this.host = "api.getalby.com",
    this.accessToken = "",
    this.refreshToken = "",
    this.clientId = "aCIvjyEzzV",
    this.clientSecret = "JlM86SQg8RNQ2Ww1JWq6",
    this.redirectUri = "https://satstreamer.app/",
    this.scopes = "invoices:read+account:read",
    this.authorizationHost = "getalby.com",
  });

  void connectAlby() async {
    //todo: PKCE
    launch(
        "https://$authorizationHost/oauth?client_id=$clientId&scope=$scopes&redirect_uri=$redirectUri");
  }

  Future<AuthResponse> continueOauthRequest(Map<String, String> params) async {
    // Use this code to get an access token
    var map = <String, dynamic>{};
    map["redirect_uri"] = redirectUri;
    map["code"] = params["code"];
    map["grant_type"] = "authorization_code";
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode("$clientId:$clientSecret"));
    var response = await http.post(Uri.parse("https://$host/oauth/token"),
        body: map, headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var payload = AuthResponse.fromJson(jsonDecode(response.body));
      accessToken = payload.accessToken!;
      refreshToken = payload.refreshToken!;
      return payload;
    } else {
      Get.snackbar("Something went wrong fetching token", response.body,
          snackPosition: SnackPosition.BOTTOM);
      throw Exception('Error fetching token');
    }
  }

  WebSocketChannel streamInvoices() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://$host/invoices/stream?token=$accessToken'),
    );
    return channel;
  }
}
