import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satstreamer/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/lndhub_controller.dart';

class ConnectLNDHub extends StatelessWidget {
  @override
  Widget build(context) {
    final LNDhubController c = Get.put(LNDhubController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 600.0, vertical: 100),
      child: Column(children: [
        TextFormField(
          controller: c.connectionStringController,
          obscureText: true,
          style: const TextStyle(color: Colors.purple),
          decoration: const InputDecoration(
            hintText: 'lndhub://username:password@https://example.com',
            hintStyle: TextStyle(color: Colors.deepPurple),
            labelText: "LNDhub connection string",
            labelStyle: TextStyle(color: Colors.deepPurple),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () => c.fetchTokenAndStartStream(),
            child: const Text("Stream")),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => {
                      launch(
                          "https://github.com/kiwiidb/satstreamer/blob/main/README.md#regtest-setup")
                    },
                child: const Text("Instructions")),
            TextButton(
                onPressed: () =>
                    {launch("https://youtu.be/INyD8XhmTas?t=2133")},
                child: const Text("Demo")),
          ],
        )
      ]),
    );
  }
}
