import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/homecontroller.dart';
import 'package:flutter_car_application/views/cartlist.dart';
import 'package:flutter_car_application/views/changepassword.dart';
import 'package:flutter_car_application/views/deleteaccount.dart';
import 'package:flutter_car_application/views/wishlist.dart';

import 'customerservice.dart';
import 'desiredpreferences.dart';
import 'home.dart';
import 'orderchecklist.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User settings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderCheckList()));
              },
              child: const Text("Check your order"),
            ),
            const SizedBox(
              height: 20,
            ),
            
            //Change password

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePassword()));
              },
              child: const Text("Change password"),
            ),
            const SizedBox(
              height: 20,
            ),

            //Delete account

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DeleteAccount()));
              },
              child: const Text("Remove your account"),
            ),
            const SizedBox(
              height: 20,
            ),

            //Wishlist

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Wishlist()));
              },
              child: const Text("Your wishlist"),
            ),
            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerService()));
              },
              child: const Text("Customer service"),
            ),
            const SizedBox(
              height: 20,
            ),
            

            ElevatedButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CartList()));
                },
                child: const Text("Your cart")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DesiredPreferences()));
                },
                child: const Text("Your current preference")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyHomePage()), (route) => false);
                },
                child: const Text("Sign out")),
          ],
        ),
      ),
    );
  }
}
