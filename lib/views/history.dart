import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:satstreamer/controllers/lndhub_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Past donations",
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 600,
          width: 400,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GetX<LNDhubController>(builder: (controller) {
              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: controller.paymentHistory.length,
                itemBuilder: (context, index) {
                  var item = controller.paymentHistory[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.invoice!.description!),
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
