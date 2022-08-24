import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/models/carmodel.dart';

class AddCarsController {
  void addCarToDB(CarModel carModel, BuildContext context) {
    FirebaseFirestore.instance.collection("cars").add(carModel.toJson());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Added successfully"),
      duration: Duration(seconds: 5),
    ));
  }
}
