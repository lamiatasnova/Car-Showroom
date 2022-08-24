import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/editpanelcontroller.dart';

import '../datastore.dart';

class EditPanel extends StatefulWidget {
  const EditPanel({Key? key}) : super(key: key);

  @override
  State<EditPanel> createState() => _EditPanelState();
}

class _EditPanelState extends State<EditPanel> {
  String categoryDropDown = InformationStore.carCategory[0];
  int carTotal = -9999999;
  double carPrice = -9999999;
  @override
  Widget build(BuildContext context) {
    EditPanelController editPanelController = EditPanelController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit panel"),
      ),
      body: Column(
        children: [
          const Text("Update total amount of cars"),
          //Change car total
          TextField(
            onChanged: (val) {
              carTotal = int.parse(val);
            },
          ),
          // change car price
          const Text("Update car price"),
          TextField(
            onChanged: (val) {
              carPrice = double.parse(val);
            },
          ),
          // change car price
          const Text("Update car category"),
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
          ElevatedButton(
              onPressed: () async {
                await editPanelController.editCarValue(
                    carTotal, carPrice, categoryDropDown, context);
              },
              child: const Text("Update")),
        ],
      ),
    );
  }
}
