import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../datastore.dart';
import '../views/userpanel.dart';

class CreditCardController {
  Future<void> payNow(String creditCard, BuildContext context) async {
    if (creditCard.length == 16) {
      // Add it to order
      for (int i = 0; i < InformationStore.cartItems.length; i++) {
        await confirmOrder(InformationStore.cartItems[i].carName!);
      }
      InformationStore.cartItems.clear();
      InformationStore.isCartOrder = false;
      InformationStore.cartPrice = 0.0;
      InformationStore.finalPrice = 0.0;
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
