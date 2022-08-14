import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/user_panel.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var boxWidth = width * 0.5;
    var email = "";
    var password = "";
    var houseAddress = "";
    var phoneNumber = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: boxWidth,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Enter Email"),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextField(
                      onChanged: (emailID) {
                        email = emailID;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: boxWidth,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Enter password"),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextField(
                      obscureText: true,
                      onChanged: (pass) {
                        password = pass;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: boxWidth,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Enter phone number"),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextField(
                      onChanged: ((phone) {
                        phoneNumber = phone;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: boxWidth,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Enter house address"),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextField(
                      onChanged: ((house) {
                        houseAddress = house;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
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
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
