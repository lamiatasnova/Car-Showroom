import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/models/discountmodel.dart';
import 'package:flutter_car_application/views/sysadmin.dart';

class DiscountController {
  Future<void> createDiscount(
      BuildContext context, String coupon, double percent) async {
    await FirebaseFirestore.instance.collection("coupons").add({
      "coupon": coupon,
      "percent": percent,
    });
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Added coupon successfully")));
    Navigator.pop(context);
  }

  Future<List<DiscountModel>> showDisounts() async {
    final snapshots =
        await FirebaseFirestore.instance.collection("coupons").get();
    final List<DiscountModel> discountList = [];
    for (var discount in snapshots.docs.toList()) {
      final data = DiscountModel.fromJson(discount.data());
      discountList.add(data);
    }
    return discountList;
  }

  Future<bool> couponExist(String discountCode) async {
    var discountList = await showDisounts();
    discountList = discountList
        .where((element) => element.coupon == discountCode)
        .toList();
    if (discountList.isEmpty) {
      return false;
    }
    return true;
  }

  Future<DiscountModel> getDiscountInfo(String discountCode) async {
    var discountList = await showDisounts();
    discountList = discountList
        .where((element) => element.coupon == discountCode)
        .toList();
    return discountList.first;
  }
}
