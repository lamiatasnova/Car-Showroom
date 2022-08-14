import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/user_panel.dart';

import '../controllers/data_store.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({Key? key}) : super(key: key);

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    String creditCard = "";
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
            ElevatedButton(
                onPressed: () async {
                  if (creditCard.length == 16) {
                    // Add it to order
                    if (InformationStore.isCartOrder) {
                      for (int i = 0; i < InformationStore.cartItems.length; i++) {
                        await confirmOrder(InformationStore.cartItems[i]);
                      }
                      InformationStore.cartItems.clear();
                    } else {
                      await confirmOrder(InformationStore.currentCarSelectedName);
                    }
                    InformationStore.currentCarSelectedName = "";
                    InformationStore.isCartOrder = false;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Car purchased successfully"),
                      duration: Duration(seconds: 5),
                    ));
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
                  } else {
                    print("invalid");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text("Failed to buy. Try again"),
                    ));
                  }
                },
                child: const Text("Pay")),
          ],
        ),
      ),
    );
  }

  Future<void> confirmOrder(String carName) async {
    await FirebaseFirestore.instance.collection("orders").add({
      "carName": carName,
      "userEmail": FirebaseAuth.instance.currentUser!.email,
      "orderStatus": "confirmed",
    });
    // reduce count of the car
    QuerySnapshot<Map<String, dynamic>> car = await FirebaseFirestore.instance.collection("cars").where("carName", isEqualTo: carName).get();
    String carID = car.docs.first.id;
    await FirebaseFirestore.instance.collection("cars").doc(carID).update({
      "totalCars": car.docs.first.data()["totalCars"] - 1,
    });
  }
}
