import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/orderchecklistcontroller.dart';
import 'package:flutter_car_application/models/ordermodel.dart';

class OrderCheckList extends StatelessWidget {
  const OrderCheckList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderCheckListController orderCheckListController = OrderCheckListController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: orderCheckListController.collectOrderList(),
          builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
            if (snapshot.hasData) {
              var orderList = snapshot.data!;
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
                              "${orderList[index].carName}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              orderList[index].orderStatus.toString().toUpperCase(),
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
