import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/lndhub_controller.dart';

class ConnectLNDHub extends StatelessWidget {
  @override
  Widget build(context) {
    final LNDhubController c = Get.put(LNDhubController());
    return Column(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "SAT STREAMER",
          style: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Container(
        width: 500,
        child: TextFormField(
          controller: c.connectionStringController,
          obscureText: true,
          style: const TextStyle(color: Colors.purple),
          decoration: const InputDecoration(
            hintText: 'lndhub://username:password@https://ln.getalby.com',
            hintStyle: TextStyle(color: Colors.purple),
            labelText: "LNDhub connection string",
            labelStyle: TextStyle(color: Colors.purple),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
          ),
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
              onPressed: () => {launch("https://youtu.be/zAY8od3Z_LA?t=6015")},
              child: const Text("Demo")),
        ],
      )
    ]);
  }
}
