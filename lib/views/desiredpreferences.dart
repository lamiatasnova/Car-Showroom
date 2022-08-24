import 'package:flutter/material.dart';

import '../datastore.dart';

class DesiredPreferences extends StatefulWidget {
  const DesiredPreferences({Key? key}) : super(key: key);

  @override
  State<DesiredPreferences> createState() => _DesiredPreferencesState();
}

class _DesiredPreferencesState extends State<DesiredPreferences> {
  String categoryDropDown = InformationStore.carCategory[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set your preference"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
            height: 20,
          ),
            const Text("Set your current desired preference"),
            const SizedBox(
            height: 20,
          ),
            Text("Your current preference is set to ${InformationStore.currentPreference}"),
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
              items: InformationStore.carCategory.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () {
                  InformationStore.currentPreference = categoryDropDown;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Preference set successfully")));
                  Navigator.pop(context);
                },
                child: const Text("Set preference"))
          ],
        ),
      ),
    );
  }
}