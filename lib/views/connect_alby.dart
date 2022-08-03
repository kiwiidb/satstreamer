import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html';

import '../controllers/lndhub_controller.dart';

class ConnectAlby extends StatelessWidget {
  @override
  Widget build(context) {
    final LNDhubController c = Get.put(LNDhubController());
    var uri = Uri.dataFromString(window.location.href);
    if (uri.queryParameters["code"] != null) {
      c.continueOauthRequest(uri.queryParameters);
    }
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 200,
          width: 500,
          child: Marquee(
            blankSpace: 20,
            startPadding: 20,
            velocity: 20,
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(fontSize: 100),
                color: Colors.purple),
            text: "sat streamer",
          ),
        ),
      ),
      ElevatedButton(
          onPressed: () => c.svc.connectAlby(),
          child: const Text("Connect your Alby account")),
      const SizedBox(
        height: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () => {
                    Get.defaultDialog(
                      title: "About",
                      content: const SizedBox(
                        width: 400,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              "With an Alby Lightning Address you can easily accept Bitcoin Lightning payments from your livestream audience. This app will show incoming payments and read their text out loud."),
                        ),
                      ),
                    )
                  },
              child: const Text("About")),
          TextButton(
              onPressed: () => {launch("https://youtu.be/zAY8od3Z_LA?t=6015")},
              child: const Text("Demo")),
        ],
      ),
    ]);
  }
}
