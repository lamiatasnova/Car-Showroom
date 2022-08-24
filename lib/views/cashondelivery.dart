import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/cashondeliverycontroller.dart';

class CashOnDelivery extends StatelessWidget {
  const CashOnDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CashOnDeliveryController cashOnDeliveryController = CashOnDeliveryController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash on delivery"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Do you want to confirm your purchase"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No")),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await cashOnDeliveryController.makePayment(context);
                    },
                    child: const Text("Yes")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
