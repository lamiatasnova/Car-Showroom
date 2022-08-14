import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyA_rXAfyrSwnPPTTsZ-TZ_8G3PTv4TcU-w",
        authDomain: "car-showroom-3e876.firebaseapp.com",
        projectId: "car-showroom-3e876",
        storageBucket: "car-showroom-3e876.appspot.com",
        messagingSenderId: "757263461272",
        appId: "1:757263461272:web:813d6feb5f0dc8bdc7d9ed"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

