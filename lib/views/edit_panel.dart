import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/user_panel.dart';

import '../controllers/data_store.dart';

class EditPanel extends StatelessWidget {
  const EditPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int carTotal = -9999999;
    double carPrice = -9999999;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit panel"),
      ),
      body: Column(
        children: [
          const Text("Update total amount of cars"),
          //Change car total
          TextField(
            onChanged: (val) {
              carTotal = int.parse(val);
            },
          ),
          // change car price
          const Text("Update car price"),
          TextField(
            onChanged: (val) {
              carPrice = double.parse(val);
            },
          ),
          ElevatedButton(
              onPressed: () async {
                QuerySnapshot<Map<String, dynamic>> car =
                    await FirebaseFirestore.instance.collection("cars").where("carName", isEqualTo: InformationStore.currentCarSelectedName).get();
                String carID = car.docs.first.id;
                await FirebaseFirestore.instance.collection("cars").doc(carID).update({
                  "totalCars": carTotal == -9999999 ? car.docs.first.data()["totalCars"] : carTotal,
                  "carPrice": carPrice == -9999999 ? car.docs.first.data()["carPrice"] : carPrice,
                });
                InformationStore.currentCarSelectedName = "";
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Update successfully"),
                  duration: Duration(seconds: 5),
                ));
              },
              child: const Text("Update")),
        ],
      ),
    );
  }
}
