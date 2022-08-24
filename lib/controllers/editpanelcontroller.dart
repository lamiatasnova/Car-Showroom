import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../datastore.dart';
import '../views/userpanel.dart';

class EditPanelController {
  Future<void> editCarValue(int carTotal, double carPrice, String category, BuildContext context) async {
    QuerySnapshot<Map<String, dynamic>> car =
        await FirebaseFirestore.instance.collection("cars").where("carName", isEqualTo: InformationStore.currentCarSelectedName).get();
    String carID = car.docs.first.id;
    await FirebaseFirestore.instance.collection("cars").doc(carID).update({
      "totalCars": carTotal == -9999999 ? car.docs.first.data()["totalCars"] : carTotal,
      "carPrice": carPrice == -9999999 ? car.docs.first.data()["carPrice"] : carPrice,
      "category": category
    });
    InformationStore.currentCarSelectedName = "";
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Update successfully"),
      duration: Duration(seconds: 5),
    ));
  }
}
