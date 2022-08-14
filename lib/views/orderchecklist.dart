import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderCheckList extends StatelessWidget {
  const OrderCheckList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("orders").where("userEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email!).get(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var orderList = snapshot.data!.docs.toList();
              return ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFF270082),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${orderList[index]["carName"]}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              orderList[index]["orderStatus"].toString().toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
