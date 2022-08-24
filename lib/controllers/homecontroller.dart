import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/models/wishlistmodel.dart';

import '../models/carmodel.dart';
import '../models/usermodel.dart';
import '../views/userpanel.dart';

class HomeController {
  Future<List<CarModel>> getCarList() async {
    final snapshot = await FirebaseFirestore.instance.collection("cars").get();
    final List<CarModel> carList = [];
    for (var car in snapshot.docs.toList()) {
      final carModel = CarModel.fromJson(car.data());
      carList.add(carModel);
    }
    return carList;
  }

  Future<void> removeCar(BuildContext context, String carName) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("cars")
        .where("carName", isEqualTo: carName)
        .get();
    final id = snapshot.docs.first.id;
    await FirebaseFirestore.instance.collection("cars").doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Car removed successfully")));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserPanel()),
        (route) => false);
  }

  Future<List<CarModel>> getCarListBasedOnSearch(String search) async {
    final snapshot = await FirebaseFirestore.instance.collection("cars").get();
    final List<CarModel> carList = [];
    for (var car in snapshot.docs.toList()) {
      final carModel = CarModel.fromJson(car.data());
      carList.add(carModel);
    }
    return carList
        .where((element) =>
            element.carCompany!.toLowerCase().contains(search.toLowerCase()) ||
            element.carName!.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  Future<UserModel> getUser(String userID) async {
    final snapshot =
        await FirebaseFirestore.instance.collection("users").doc(userID).get();
    final user = UserModel.fromJson(snapshot.data()!);
    return user;
  }

  Future<List<WishlistModel>> getWishlists() async {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    final snapshot = await FirebaseFirestore.instance
        .collection("wishlist")
        .where("email", isEqualTo: userEmail)
        .get();
    final List<WishlistModel> wishList = [];
    for (var w in snapshot.docs.toList()) {
      final wishlistModel = WishlistModel.fromJson(w.data());
      wishList.add(wishlistModel);
    }
    return wishList;
  }

  Future<void> addWishlist(
      BuildContext context, CarModel carModel, String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("wishlist")
        .where(
          "carName",
          isEqualTo: carModel.carName,
        )
        .where(
          "email",
          isEqualTo: email,
        )
        .get();
    final carList = snapshot.docs.toList();
    if (carList.isEmpty) {
      //add to wishlist
      await FirebaseFirestore.instance.collection("wishlist").add({
        "email": email,
        "carName": carModel.carName,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Successfully added to wishlist")));
    } else {
      //it exists
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You already have it in the wishlist")));
    }
  }
}
