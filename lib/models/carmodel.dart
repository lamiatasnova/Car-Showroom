import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
  CarModel({
    this.carCompany,
    this.carHorsePower,
    this.carImageLink,
    this.carName,
    this.carPrice,
    this.carTopSpeed,
    this.totalCars,
    this.category,
  });

  String? carCompany;
  String? carHorsePower;
  String? carImageLink;
  String? carName;
  double? carPrice;
  String? carTopSpeed;
  int? totalCars;
  String? category;

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        carCompany: json["carCompany"],
        carHorsePower: json["carHorsePower"],
        carImageLink: json["carImageLink"],
        carName: json["carName"],
        carPrice: json["carPrice"],
        carTopSpeed: json["carTopSpeed"],
        totalCars: json["totalCars"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "carCompany": carCompany,
        "carHorsePower": carHorsePower,
        "carImageLink": carImageLink,
        "carName": carName,
        "carPrice": carPrice,
        "carTopSpeed": carTopSpeed,
        "totalCars": totalCars,
        "category": category,
      };
}