import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/user_panel.dart';

class AddCars extends StatefulWidget {
  const AddCars({Key? key}) : super(key: key);

  @override
  State<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {
  @override
  Widget build(BuildContext context) {
    String cName = "";
    String cCompany = "";
    String cHP = "";
    String cTP = "";
    String cImage = "";
    double price = 0;
    int totalCars = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add cars"),
      ),
      body: Center(
        child: Column(
          children: [
            //car company
            const Text("Car company"),
            TextField(
              onChanged: (val) {
                cCompany = val;
              },
            ),
            // car model
            const Text("Car model"),
            TextField(
              onChanged: (val) {
                cName = val;
              },
            ),
            //car hourse power
            const Text("Car engine power"),
            TextField(
              onChanged: (val) {
                cHP = val;
              },
            ),
            // car top speed
            const Text("Car topspeed"),
            TextField(
              onChanged: (val) {
                cTP = val;
              },
            ),
            // car image
            const Text("Car image link"),
            TextField(
              onChanged: (val) {
                cImage = val;
              },
            ),
            // Car price
            const Text("Car price"),
            TextField(
              onChanged: (val) {
                price = double.parse(val);
              },
            ),
            const Text("Total cars"),
            TextField(
              onChanged: (val) {
                totalCars = int.parse(val);
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  FirebaseFirestore.instance.collection("cars").add({
                    "carName": cName,
                    "carCompany": cCompany,
                    "carHorsePower": cHP,
                    "carTopSpeed": cTP,
                    "carImageLink": cImage,
                    "carPrice": price,
                    "totalCars": totalCars
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Added successfully"),
                    duration: Duration(seconds: 5),
                  ));
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
