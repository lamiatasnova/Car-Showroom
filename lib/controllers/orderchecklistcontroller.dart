import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/ordermodel.dart';

class OrderCheckListController {
  Future<List<OrderModel>> collectOrderList() async {
    final snapshot = await FirebaseFirestore.instance.collection("orders").where("userEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email!).get();
    final List<OrderModel> orderList = [];
    for (var order in snapshot.docs.toList()) {
      final orderModel = OrderModel.fromJson(order.data());
      orderList.add(orderModel);
    }
    return orderList;
  }
}
