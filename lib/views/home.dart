import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satstreamer/controllers/lndhub_controller.dart';

class Home extends StatelessWidget {
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final LNDhubController c = Get.put(LNDhubController());

    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 600.0, vertical: 100),
        child: Column(children: [
          TextFormField(
            controller: c.connectionStringController,
            decoration: const InputDecoration.collapsed(
                hintText: 'LNDhub connection string'),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () => c.fetchToken(), child: const Text("Stream"))
        ]),
      ),
    ));
  }
}
