import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/userpanel.dart';

class SignUpController {
  Future<void> signUp(String email, String password, String houseAddress, String phoneNumber, BuildContext context) async {
    log("email is $email");
    if (email.isEmpty && password.isEmpty && houseAddress.isEmpty && phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill the required data"),
        duration: Duration(seconds: 5),
      ));
    } else {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        String id = value.user!.uid;
        FirebaseFirestore.instance
            .collection("users")
            .doc(id)
            .set({"email": email, "houseAddress": houseAddress, "phoneNumber": phoneNumber, "role": "user"});
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
      });
    }
  }
}
