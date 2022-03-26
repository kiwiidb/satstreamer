import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:satstreamer/controllers/lndhub_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: 400,
          child: Text(
            "Contribution history",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(children: [
                              Text(
                                item.invoice!.amt.toString(),
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.orange[700],
                                    fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    " sat",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.orange[700]),
                                  ),
                                ],
                              )
                            ]),
                            SelectableText(
                              item.invoice!.description!,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
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
