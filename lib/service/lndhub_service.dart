import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:satstreamer/models/ln_address.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:crypto/crypto.dart';
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
//  LNDHubService({
//    this.host = "api.regtest.getalby.com",
//    this.accessToken = "",
//    this.refreshToken = "",
//    this.clientId = "test_client",
//    this.clientSecret = "test_secret",
//    this.redirectUri = "http://localhost:8080/",
//    this.scopes = "invoices:read+account:read",
//    this.authorizationHost = "app.regtest.getalby.com",
//  });

  void connectAlby(String codeVerifier) async {
    var codeChallenge =
        base64UrlEncode(sha256.convert(utf8.encode(codeVerifier)).bytes);
    launch(
        "https://$authorizationHost/oauth?client_id=$clientId&scope=$scopes&redirect_uri=$redirectUri&code_challenge=$codeChallenge&code_challenge_method=S256");
  }

  Future<AuthResponse> continueOauthRequest(
      Map<String, String> params, String verifier) async {
    //todo: remove code from url
    var map = <String, dynamic>{};
    map["redirect_uri"] = redirectUri;
    map["code"] = params["code"];
    map["grant_type"] = "authorization_code";
    map["code_verifier"] = verifier;
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

  Future<AuthResponse> refreshOauth(String refresh) async {
    var map = <String, dynamic>{};
    map["redirect_uri"] = redirectUri;
    map["refresh_token"] = refresh;
    map["grant_type"] = "refresh_token";
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
      Get.snackbar("Something went wrong refreshing token", response.body,
          snackPosition: SnackPosition.BOTTOM);
      throw Exception('Error fetching token');
    }
  }

  Future<LNAddressResponse> getAddress() async {
    //todo: remove code from url
    var response = await http.get(Uri.parse("https://$host/user/value4value"),
        headers: <String, String>{'authorization': accessToken});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var payload = LNAddressResponse.fromJson(jsonDecode(response.body));
      return payload;
    } else {
      throw Exception('Error fetching ln address info');
    }
  }

  WebSocketChannel streamInvoices() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://$host/invoices/stream?token=$accessToken'),
    );
    return channel;
  }
}
