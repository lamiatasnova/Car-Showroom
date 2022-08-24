import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/homecontroller.dart';
import 'package:flutter_car_application/datastore.dart';

class PromptDeleteCar extends StatelessWidget {
  const PromptDeleteCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete the car"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text("Are you sure you want to delete this car?"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await homeController.removeCar(
                        context, InformationStore.currentCarSelectedName);
                  },
                  child: const Text("Yes"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
