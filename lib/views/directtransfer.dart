import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/cashondeliverycontroller.dart';

class DirectTransfer extends StatelessWidget {
  const DirectTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CashOnDeliveryController cashOnDeliveryController = CashOnDeliveryController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct bank transfer"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
            height: 20,
          ),
            const Text("BRAC Bank"),
            const SizedBox(
            height: 10,
          ),
            const Text("912338297783728378"),
            const SizedBox(
            height: 10,
          ),
            const Text("Please call 012345678931 for confirming your order"),
            const SizedBox(
            height: 10,
          ),
            ElevatedButton(
              onPressed: () {
                cashOnDeliveryController.makePayment(context);
              },
              child: const Text("Confirm"),
            )
          ],
        ),
      ),
    );
  }
}
