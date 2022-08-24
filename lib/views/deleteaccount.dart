import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/removeaccountcontroller.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RemoveAccountController removeAccountController = RemoveAccountController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remove your account"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text("Do you want to delete your account?"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    await removeAccountController.removeaccount(context);
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
