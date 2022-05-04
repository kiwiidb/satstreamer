import 'package:flutter/material.dart';
import 'package:satstreamer/views/banner.dart';
import 'package:satstreamer/views/webcam.dart';

class StreamView extends StatelessWidget {
  const StreamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      MessageBanner(),
      WebcamView(),
    ]);
  }
}
