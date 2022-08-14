import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/user_panel.dart';

import '../controllers/data_store.dart';


class CashOnDelivery extends StatelessWidget {
  const CashOnDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Do you want to confirm your purchase"),
            const SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No")),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection("orders").add({
                        "carName": InformationStore.currentCarSelectedName,
                        "userEmail": FirebaseAuth.instance.currentUser!.email,
                        "orderStatus": "confirmed",
                      });
                      // reduce count of the car
                      QuerySnapshot<Map<String, dynamic>> car =
                          await FirebaseFirestore.instance.collection("cars").where("carName", isEqualTo: InformationStore.currentCarSelectedName).get();
                      String carID = car.docs.first.id;
                      await FirebaseFirestore.instance.collection("cars").doc(carID).update({
                        "totalCars": car.docs.first.data()["totalCars"] - 1,
                      });
                      InformationStore.currentCarSelectedName = "";
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Car purchased successfully"),
                        duration: Duration(seconds: 5),
                      ));
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
                    },
                    child: const Text("Yes")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
