import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satstreamer/views/ln_address.dart';

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
      height: totalHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AddressView(),
          Obx((() {
            if (!c.receivedPayment.value) {
              return SizedBox(
                width: totalWidth * 0.15,
                height: totalHeight / 2,
                child: const Center(
                  child: Text(
                    "Waiting for payment...",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              var payment = c.lastPayment.value.invoice!;
              if (c.showHighest.value) {
                payment = c.highestPayment.value.invoice!;
              }
              var msg = payment.description!;
              return SizedBox(
                width: totalWidth * 0.15,
                height: totalHeight / 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "🥳 Latest donation: ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.purple),
                              ),
                            ],
                          ),
                          Text(
                            payment.amt.toString(),
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
                        ],
                      ),
                    ),
                    Container(
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
                  ],
                ),
              );
            }
          })),
        ],
      ),
    );
  }
}
