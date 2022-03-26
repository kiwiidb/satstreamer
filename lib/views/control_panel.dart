import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        width: 400,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Show media from image links in payment"),
                  (Text("Auto-open links from payment")),
                  (Text("Text to speech")),
                  (Text("Voice language")),
                  (Text("Voice volume")),
                ]),
          ),
        ));
  }
}
