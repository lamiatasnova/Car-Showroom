import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/main.dart';

import 'addcar.dart';
import 'home.dart';

class SysAdmin extends StatefulWidget {
  const SysAdmin({Key? key}) : super(key: key);

  @override
  State<SysAdmin> createState() => _SysAdminState();
}

class _SysAdminState extends State<SysAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("System admin panel"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCars()));
                },
                child: const Text("Add cars")),
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
