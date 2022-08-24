import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.email,
    this.houseAddress,
    this.phoneNumber,
    this.role,
  });

  String? email;
  String? houseAddress;
  String? phoneNumber;
  String? role;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        houseAddress: json["houseAddress"],
        phoneNumber: json["phoneNumber"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "houseAddress": houseAddress,
        "phoneNumber": phoneNumber,
        "role": role,
      };
}
