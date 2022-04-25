import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lndhub_controller.dart';

class NewPaymentView extends StatelessWidget {
  const NewPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LNDhubController c = Get.put(LNDhubController());
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height - 60;
    return SizedBox(
      width: totalWidth / 3,
      height: totalHeight * 0.6,
      child: Obx((() {
        if (!c.receivedPayment.value) {
          return const Center(
              child: Text(
            "Waiting for payment...",
            textAlign: TextAlign.center,
          ));
        } else {
          var payment = c.lastPayment.value.invoice!;
          if (c.showHighest.value) {
            payment = c.highestPayment.value.invoice!;
          }
          var msg = payment.description!;
          var img = Image.asset(
            c.getRandomGif(),
            width: 300,
          );
          if (payment.description!.isImageFileName &&
              c.showMediaFromPayments.value) {
            img = Image.network(
              payment.description!,
              width: 300,
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
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
                    height: totalHeight * 0.25,
                    width: totalWidth * 0.2,
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
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: img,
              ),
            ],
          );
        }
      })),
    );
  }
}
