import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/addcarscontroller.dart';
import 'package:flutter_car_application/datastore.dart';
import 'package:flutter_car_application/models/carmodel.dart';
import 'package:flutter_car_application/views/userpanel.dart';

class AddCars extends StatefulWidget {
  const AddCars({Key? key}) : super(key: key);

  @override
  State<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {
  String cName = "";
  String cCompany = "";
  String cHP = "";
  String cTP = "";
  String cImage = "";
  double price = 0;
  int totalCars = 0;
  String categoryDropDown = InformationStore.carCategory[0];
  @override
  Widget build(BuildContext context) {
    AddCarsController addCarsController = AddCarsController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add cars"),
      ),
      body: Center(
        child: Column(
          children: [
            //car company
            const Text("Car company"),
            TextField(
              onChanged: (val) {
                cCompany = val;
              },
            ),
            // car model
            const Text("Car model"),
            TextField(
              onChanged: (val) {
                cName = val;
              },
            ),
            //car hourse power
            const Text("Car engine power"),
            TextField(
              onChanged: (val) {
                cHP = val;
              },
            ),
            // car top speed
            const Text("Car topspeed"),
            TextField(
              onChanged: (val) {
                cTP = val;
              },
            ),
            // car image
            const Text("Car image link"),
            TextField(
              onChanged: (val) {
                cImage = val;
              },
            ),
            const Text("Category"),
            DropdownButton<String>(
              value: categoryDropDown,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              underline: Container(
                height: 2,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  categoryDropDown = newValue!;
                });
              },
              items: InformationStore.carCategory
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Car price
            const Text("Car price"),
            TextField(
              onChanged: (val) {
                price = double.parse(val);
              },
            ),
            const Text("Total cars"),
            TextField(
              onChanged: (val) {
                totalCars = int.parse(val);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  addCarsController.addCarToDB(
                      CarModel.fromJson({
                        "carName": cName,
                        "carCompany": cCompany,
                        "carHorsePower": cHP,
                        "carTopSpeed": cTP,
                        "carImageLink": cImage,
                        "carPrice": price,
                        "totalCars": totalCars,
                        "category": categoryDropDown,
                      }),
                      context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserPanel()),
                      (route) => false);
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
