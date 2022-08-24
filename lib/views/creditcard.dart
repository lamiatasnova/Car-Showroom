import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/creditcardcontroller.dart';


class CreditCard extends StatefulWidget {
  const CreditCard({Key? key}) : super(key: key);

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    String creditCard = "";
    CreditCardController creditCardController = CreditCardController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credit card info"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Enter your credit card number"),
            TextField(
              onChanged: (val) {
                creditCard = val;
              },
            ),
            const SizedBox(
            height: 20,
          ),
            ElevatedButton(
                onPressed: () async {
                  await creditCardController.payNow(creditCard, context);
                },
                
                child: const Text("Pay")),
          ],
        ),
      ),
    );
  }
}
