import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:satstreamer/views/connect_lndhub.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Sat Streamer",
                style: TextStyle(
                    fontSize: 72.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
            ),
            ConnectLNDHub(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () =>
                  {launch("https://github.com/kiwiidb/satstreamer")},
              icon: const FaIcon(
                FontAwesomeIcons.github,
                color: Colors.deepPurple,
              ),
            ),
            TextButton(
                onPressed: () => {launch("https://getalby.com")},
                child: Image.asset(
                  "images/alby.png",
                )),
            IconButton(
              onPressed: () => {launch("https://twitter.com/getalby")},
              icon: const FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.deepPurple,
              ),
            ),
            TextButton(
              onPressed: () =>
                  {launch("https://bolt.fun/hackathons/shock-the-web/")},
              child: Image.asset(
                "images/boltfun.png",
              ),
            )
          ],
        ),
      )),
    );
  }
}
