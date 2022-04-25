import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:satstreamer/controllers/lndhub_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height - 60;
    return SizedBox(
      height: totalHeight,
      width: totalWidth / 3,
      child: Column(
        children: [
          const Text(
            "Contribution history",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),
          const SizedBox(
            height: 5,
          ),
          GetX<LNDhubController>(builder: (controller) {
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.paymentHistory.length,
              itemBuilder: (context, index) {
                var item = controller.paymentHistory[
                    controller.paymentHistory.length - 1 - index];
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
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                            Column(
                              children: const [
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  " sat",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.purple),
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
        ],
      ),
    );
  }
}
