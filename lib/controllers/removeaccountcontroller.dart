import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/home.dart';

class RemoveAccountController {
  Future<void> removeaccount(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final ref = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: user!.email).get();
    final uuid = ref.docs.first.id;
    await FirebaseFirestore.instance.collection("users").doc(uuid).delete();
    await user.delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Removed successfully")));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyHomePage()), (route) => false);
  }
}
