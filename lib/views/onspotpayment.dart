import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/onspotpaymentcontroller.dart';
import 'package:flutter_car_application/datastore.dart';
import 'package:flutter_car_application/models/carmodel.dart';

class OnSpotPayment extends StatelessWidget {
  const OnSpotPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userEmail = FirebaseAuth.instance.currentUser!.email!;
    OnSpotPaymentController onSpotPaymentController = OnSpotPaymentController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("On Spot payment"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
              "Do you want to confirm your order and recieve it on spot?"),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    // add onspot ticket
                    await onSpotPaymentController.onspotpayment(
                        context, userEmail);
                  },
                  child: const Text("Yes")),
            ],
          )
        ],
      ),
    );
  }
}
