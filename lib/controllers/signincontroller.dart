import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/userpanel.dart';

class SignInController {
  Future<void> signIn({required BuildContext context, required String emailID, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailID, password: password);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign in failed")));
    }
  }
}
