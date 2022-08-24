import 'package:flutter/material.dart';
import 'package:flutter_car_application/datastore.dart';
import 'package:flutter_car_application/views/directtransfer.dart';

class InstallmentPayment extends StatelessWidget {
  const InstallmentPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Text("You have to pay through 4 instalments. The payment will be done through direct transfer"),
            const SizedBox(
            height: 10,
          ),
            Text("First instalment 40%: ${(InformationStore.finalPrice * 0.4).toStringAsFixed(2)}"),
            const SizedBox(
            height: 10,
          ),
            Text("Second instalment 30%: ${(InformationStore.finalPrice * 0.3).toStringAsFixed(2)}"),
            const SizedBox(
            height: 10,
          ),
            Text("Third instalment 20%: ${(InformationStore.finalPrice * 0.2).toStringAsFixed(2)}"),
            const SizedBox(
            height: 10,
          ),
            Text("Forth instalment 10%: ${(InformationStore.finalPrice * 0.1).toStringAsFixed(2)}"),
            const SizedBox(
            height: 10,
          ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DirectTransfer()));
                },
                
                child: const Text("Pay"))
          ],
        ),
      ),
    );
  }
}
