import 'package:flutter/material.dart';
import 'package:flutter_car_application/datastore.dart';
import 'package:flutter_car_application/views/directtransfer.dart';
import 'package:flutter_car_application/views/onspotpayment.dart';

import 'cashondelivery.dart';
import 'creditcard.dart';
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
            Text("Cart price: ${InformationStore.cartPrice}"),
            const SizedBox(
              height: 20,
            ),
            Text("Discount: ${InformationStore.discountPercentage}%"),
            const SizedBox(
              height: 20,
            ),
            Text("Total price after discount: ${InformationStore.finalPrice.toStringAsFixed(2)}"),
            const SizedBox(
              height: 50,
            ),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DirectTransfer()));
              },
              child: const Text("Direct transfer"),
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OnSpotPayment()));
              },
              child: const Text("Onspot payment"),
            ),
          ],
        ),
      ),
    );
  }
}
