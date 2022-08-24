import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/changepasswordcontroller.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentPassword = "";
    String newPassword = "";
    ChangePasswordController changePasswordController = ChangePasswordController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change your password"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              obscureText: true,
              onChanged: (value) => currentPassword = value,
              decoration: const InputDecoration(label: Text("Current password")),
            ),
            TextField(
              obscureText: true,
              onChanged: (value) => newPassword = value,
              decoration: const InputDecoration(label: Text("New password")),
            ),
            const SizedBox(
            height: 20,
          ),
            ElevatedButton(
                onPressed: () async {
                  var result = await changePasswordController.changePassword(currentPassword, newPassword);
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password changed successfully")));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password change failed. Try again")));
                  }
                },
                
                child: const Text("Change password"))
          ],
        ),
      ),
    );
  }
}
