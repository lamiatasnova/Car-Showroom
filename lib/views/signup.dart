import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/signupcontroller.dart';
import 'package:flutter_car_application/views/userpanel.dart';

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
    SignUpController signUpController = SignUpController();
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
                  await signUpController.signUp(email, password, houseAddress, phoneNumber, context);
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
