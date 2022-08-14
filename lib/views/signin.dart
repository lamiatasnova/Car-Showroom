import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/user_panel.dart';

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
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailID, password: password);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPanel()), (route) => false);
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign in failed")));
                  }
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
