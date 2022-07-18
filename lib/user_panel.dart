import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                    
                  } else {
                    // Go to user settings
                    
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
                                    carList[index]["totalCars"] == 0
                                        ? Container()
                                        : m["role"] == "sysAdmin"
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  // edit for admin only
                                                },
                                                child: const Text("EDIT"),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  // Buy implement
                                                },
                                                child: const Text("Buy now"))
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
