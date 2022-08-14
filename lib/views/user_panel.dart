import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/payment_panel.dart';
import 'package:flutter_car_application/views/sysadmin.dart';
import 'package:flutter_car_application/views/user_settings.dart';

import '../controllers/data_store.dart';
import 'edit_panel.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userMail = FirebaseAuth.instance.currentUser!.email!;
    String userID = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").doc(userID).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot<Map<String, dynamic>> m = snapshot.data as DocumentSnapshot<Map<String, dynamic>>;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Welcome to Car Showroom'),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  print("The role of tthe users is ${m["role"]}");
                  if (m["role"] == "sysAdmin") {
                    // Go to admin settings
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SysAdmin()));
                  } else {
                    // Go to user settings
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserSettings()));
                  }
                },
                child: const Icon(Icons.settings),
              ),
              body: Center(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance.collection("cars").get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasData) {
                        var carList = snapshot.data!.docs.toList();
                        carList.sort(((a, b) => a["carCompany"].toString().compareTo(b["carCompany"].toString())));
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: carList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      carList[index]["carImageLink"],
                                      height: 140,
                                    ),
                                    Text("Car company: ${carList[index]["carCompany"]}"),
                                    Text("Car model: ${carList[index]["carName"]}"),
                                    Text("Engine: ${carList[index]["carHorsePower"]}"),
                                    Text("Topspeed: ${carList[index]["carTopSpeed"]}"),
                                    Text("Price: \$ ${carList[index]["carPrice"]}"),
                                    carList[index]["totalCars"] == 0
                                        ? const Text("Out of stock")
                                        : Text("Total cars available: ${carList[index]["totalCars"]}"),
                                    m["role"] == "sysAdmin"
                                        ? ElevatedButton(
                                            onPressed: () {
                                              // edit for admin only
                                              InformationStore.currentCarSelectedName = carList[index]["carName"];
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditPanel()));
                                            },
                                            child: const Text("EDIT"),
                                          )
                                        : carList[index]["totalCars"] == 0
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        // Buy implement
                                                        InformationStore.currentCarSelectedName = carList[index]["carName"];
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPanel()));
                                                      },
                                                      child: const Text("Buy now")),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        InformationStore.cartItems.add(carList[index]["carName"]);
                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                          content: Text("Added to cart successfully"),
                                                        ));
                                                      },
                                                      child: const Text("Add to cart"),
                                                    ),
                                                  ),
                                                ],
                                              )
                                  ],
                                ),
                              );
                            });
                      } else {
                        return const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));
                      }
                    }),
              ),
            );
          } else {
            return const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));
          }
        });
  }
}
