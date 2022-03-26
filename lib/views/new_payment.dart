import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lndhub_controller.dart';

class NewPaymentView extends StatelessWidget {
  const NewPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());
    return SizedBox(
      height: 500,
      width: 500,
      child: Obx((() {
        if (!c.receivedPayment.value) {
          return const Text("Waiting for payment...");
        } else {
          var payment = c.lastPayment.value.invoice!;
          var msg = payment.description!;
          return Container(
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Latest contribution: ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                        ],
                      ),
                      Text(
                        payment.amt.toString(),
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
                                fontSize: 18, color: Colors.orange[700]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SelectableText(
                          msg,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    c.getRandomGif(),
                    width: 300,
                  ),
                ),
              ],
            ),
          );
        }
      })),
    );
  }
}
