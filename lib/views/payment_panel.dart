import 'package:flutter/material.dart';

import 'cashondelivery.dart';
import 'credit_card.dart';
import 'installmentpayment.dart';

class PaymentPanel extends StatelessWidget {
  const PaymentPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment methods"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Choose your payment method"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CashOnDelivery()));
              },
              child: const Text("Cash on delivery"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreditCard()));
              },
              child: const Text("Payment using credit/debit card"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InstallmentPayment()));
              },
              child: const Text("Installment payment"),
            ),
          ],
        ),
      ),
    );
  }
}
