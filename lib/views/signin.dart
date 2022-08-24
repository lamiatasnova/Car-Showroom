import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/signincontroller.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var password = "";
  var emailID = "";
  @override
  Widget build(BuildContext context) {
    SignInController signInController = SignInController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Enter your email"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (email) {
                  emailID = email;
                },
              ),
            ),
            const Text("Enter your password"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                obscureText: true,
                onChanged: (pass) {
                  password = pass;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await signInController.signIn(context: context, emailID: emailID, password: password);
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
