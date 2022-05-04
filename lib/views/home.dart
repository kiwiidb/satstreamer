import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satstreamer/views/connect_lndhub.dart';
import 'package:satstreamer/views/stream.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final HomeController c = Get.put(HomeController());
    var widgets = [
      ConnectLNDHub(),
      const StreamView(),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(child: Obx(() => widgets[c.currentTabIndex.value])),
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => {launch("https://getalby.com")},
                  child: Row(
                    children: [
                      Image.asset(
                        "images/alby.png",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Powered by getalby.com",
                          style: GoogleFonts.roboto(
                              fontSize: 25, fontWeight: FontWeight.bold))
                    ],
                  )),
              IconButton(
                onPressed: () =>
                    {launch("https://github.com/kiwiidb/satstreamer")},
                icon: const FaIcon(
                  FontAwesomeIcons.github,
                  color: Colors.purple,
                ),
              ),
              TextButton(
                onPressed: () =>
                    {launch("https://bolt.fun/hackathons/shock-the-web/")},
                child: Image.asset(
                  "images/logo-guide.png",
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
