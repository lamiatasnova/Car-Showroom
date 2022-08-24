import 'package:flutter/material.dart';
import 'package:flutter_car_application/models/usermodel.dart';
import 'package:flutter_car_application/views/promptdeletecar.dart';

import '../controllers/homecontroller.dart';
import '../datastore.dart';
import '../models/carmodel.dart';
import 'editpanel.dart';

class SearchResults extends StatelessWidget {
  final String searchQuery;
  final UserModel? user;
  const SearchResults({Key? key, required this.searchQuery, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search results"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: homeController.getCarListBasedOnSearch(searchQuery),
          builder: (context, AsyncSnapshot<List<CarModel>> snapshot) {
            if (snapshot.hasData) {
              var carList = snapshot.data!;
              carList.sort(((a, b) =>
                  a.carCompany.toString().compareTo(b.carCompany.toString())));
              if (searchQuery.isEmpty || carList.isEmpty) {
                return const Center(
                  child: Text("Search results not found"),
                );
              } else {
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
                            Text("Car company: ${carList[index].carCompany}"),
                            Text("Car model: ${carList[index].carName}"),
                            Text("Engine: ${carList[index].carHorsePower}"),
                            Text("Topspeed: ${carList[index].carTopSpeed}"),
                            Text("Price: \$ ${carList[index].carPrice}"),
                            carList[index].totalCars == 0
                                ? const Text("Out of stock")
                                : Text(
                                    "Total cars available: ${carList[index].totalCars}"),
                            user == null
                                ? Container()
                                : user!.role == "sysAdmin"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              // edit for admin only
                                              InformationStore
                                                      .currentCarSelectedName =
                                                  carList[index].carName!;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PromptDeleteCar()));
                                            },
                                            child: const Text("Remove car"),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // edit for admin only
                                              InformationStore
                                                      .currentCarSelectedName =
                                                  carList[index].carName!;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EditPanel()));
                                            },
                                            child: const Text("EDIT"),
                                          ),
                                        ],
                                      )
                                    : carList[index].totalCars == 0
                                        ? Container()
                                        : ElevatedButton(
                                            onPressed: () {
                                              InformationStore.cartItems
                                                  .add(carList[index]);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Added to cart successfully"),
                                              ));
                                            },
                                            child: const Text("Add to cart"),
                                          )
                          ],
                        ),
                      );
                    });
              }
            } else {
              return const Center(
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()));
            }
          }),
    );
  }
}
