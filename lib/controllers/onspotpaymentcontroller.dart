import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../datastore.dart';
import '../views/userpanel.dart';

class OnSpotPaymentController {
  Future<void> onspotpayment(BuildContext context, String userEmail) async {
    await FirebaseFirestore.instance
        .collection("onspot")
        .add({"email": userEmail, "carList": List<dynamic>.from(InformationStore.cartItems.map((x) => x.toJson())), "price": InformationStore.finalPrice});
    await makePayment(context);
  }

  Future<void> makePayment(BuildContext context) async {
    for (int i = 0; i < InformationStore.cartItems.length; i++) {
      await confirmOrder(InformationStore.cartItems[i].carName!);
    }
    InformationStore.cartItems.clear();
    InformationStore.isCartOrder = false;
    InformationStore.cartPrice = 0.0;
    InformationStore.finalPrice = 0.0;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order done successfully. Contact the store regarding your order")));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
  }

  Future<void> confirmOrder(String carName) async {
    await FirebaseFirestore.instance.collection("orders").add({
      "carName": carName,
      "userEmail": FirebaseAuth.instance.currentUser!.email,
      "orderStatus": "onspot",
    });
    // reduce count of the car
    QuerySnapshot<Map<String, dynamic>> car = await FirebaseFirestore.instance.collection("cars").where("carName", isEqualTo: carName).get();
    String carID = car.docs.first.id;
    await FirebaseFirestore.instance.collection("cars").doc(carID).update({
      "totalCars": car.docs.first.data()["totalCars"] - 1,
    });
  }
}
