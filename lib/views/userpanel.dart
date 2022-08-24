import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/homecontroller.dart';
import 'package:flutter_car_application/models/carmodel.dart';
import 'package:flutter_car_application/models/usermodel.dart';
import 'package:flutter_car_application/views/promptdeletecar.dart';
import 'package:flutter_car_application/views/searchresults.dart';
import 'package:flutter_car_application/views/sysadmin.dart';
import 'package:flutter_car_application/views/usersettings.dart';

import '../datastore.dart';
import 'editpanel.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    String userMail = FirebaseAuth.instance.currentUser!.email!;
    String userID = FirebaseAuth.instance.currentUser!.uid;
    String searchQuery = "";
    HomeController homeController = HomeController();
    return FutureBuilder(
        future: homeController.getUser(userID),
        builder: (context, AsyncSnapshot<dynamic> userSnapshot) {
          if (userSnapshot.hasData) {
            final user = userSnapshot.data! as UserModel;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Welcome to Car Showroom'),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  if (user.role == "sysAdmin") {
                    // Go to admin settings
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SysAdmin()));
                  } else {
                    // Go to user settings
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserSettings()));
                  }
                },
                child: const Icon(Icons.settings),
              ),
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: width * 0.9,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            suffix: IconButton(
                                onPressed: () {
                                  // search the list
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchResults(
                                                searchQuery: searchQuery,
                                                user: user,
                                              )));
                                },
                                icon: const Icon(
                                  Icons.search,
                                ))),
                        onChanged: (val) {
                          searchQuery = val;
                        },
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: homeController.getCarList(),
                          builder: (context,
                              AsyncSnapshot<List<CarModel>> snapshot) {
                            if (snapshot.hasData) {
                              var carList = snapshot.data!;
                              carList.sort(((a, b) => a.carCompany
                                  .toString()
                                  .compareTo(b.carCompany.toString())));
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: carList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            carList[index].carImageLink!,
                                            height: 140,
                                          ),
                                          Text(
                                              "Car company: ${carList[index].carCompany}"),
                                          Text(
                                              "Car model: ${carList[index].carName}"),
                                          Text(
                                              "Engine: ${carList[index].carHorsePower}"),
                                          Text(
                                              "Topspeed: ${carList[index].carTopSpeed}"),
                                          Text(
                                              "Category: ${carList[index].category}"),
                                          Text(
                                              "Price: \$ ${carList[index].carPrice}"),
                                          carList[index].totalCars == 0
                                              ? const Text("Out of stock")
                                              : Text(
                                                  "Total cars available: ${carList[index].totalCars}"),
                                          user.role == "sysAdmin"
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // edit for admin only
                                                        InformationStore
                                                                .currentCarSelectedName =
                                                            carList[index]
                                                                .carName!;
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const PromptDeleteCar()));
                                                      },
                                                      child: const Text(
                                                          "Remove car"),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // edit for admin only
                                                        InformationStore
                                                                .currentCarSelectedName =
                                                            carList[index]
                                                                .carName!;
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const EditPanel()));
                                                      },
                                                      child: const Text("EDIT"),
                                                    ),
                                                  ],
                                                )
                                              : carList[index].totalCars == 0
                                                  ? Container()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            InformationStore
                                                                .cartItems
                                                                .add(carList[
                                                                    index]);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  "Added to cart successfully"),
                                                            ));
                                                          },
                                                          child: const Text(
                                                              "Add to cart"),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            await homeController
                                                                .addWishlist(
                                                                    context,
                                                                    carList[
                                                                        index],
                                                                    userMail);
                                                          },
                                                          child: const Text(
                                                              "Add to wishlist"),
                                                        ),
                                                      ],
                                                    )
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator()));
                            }
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text("ERROR OCCURED ${userSnapshot.error}"),
            );
          } else {
            return const Center(
                child: SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator()));
          }
        });
  }
}
