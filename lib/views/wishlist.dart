import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/homecontroller.dart';
import 'package:flutter_car_application/models/wishlistmodel.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your wishlist"),
        centerTitle: true,
      ),
      body: Center(
          child: FutureBuilder(
              future: homeController.getWishlists(),
              builder: (context, AsyncSnapshot<List<WishlistModel>> snapshot) {
                if (snapshot.hasData) {
                  var wishlist = snapshot.data!;
                  if (wishlist.isEmpty) {
                    return const Center(
                      child: Text("Your wishlist is empty"),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(wishlist[index].carName!),
                      ),
                      itemCount: wishlist.length,
                    );
                  }
                } else {
                  return const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));
                }
              })),
    );
  }
}
