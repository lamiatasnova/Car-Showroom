import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_application/signin.dart';
import 'package:flutter_car_application/signup.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Car Showroom'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //button
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
          //     },
          //     child: const Text("Sign in")),
          // //button
          // const SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
                    },
                    child: const Text("Sign in")),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                    },
                    child: const Text("Sign up")),
              ],
            ),
          ),
          // Available cars
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("cars").get(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    var carList = snapshot.data!.docs.toList();
                    carList.sort(((a, b) => a["carCompany"].toString().compareTo(b["carCompany"].toString())));
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: carList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.network(
                                  carList[index]["carImageLink"],
                                  height: 140,
                                ),
                                Text("Car company: ${carList[index]["carCompany"]}"),
                                Text("Car model: ${carList[index]["carName"]}"),
                                Text("Engine: ${carList[index]["carHorsePower"]}"),
                                Text("Topspeed: ${carList[index]["carTopSpeed"]}"),
                                Text("Price: \$ ${carList[index]["carPrice"]}"),
                                carList[index]["totalCars"] == 0 ? const Text("Out of stock") : Text("Total cars available: ${carList[index]["totalCars"]}"),
                              ],
                            ),
                          );
                        });
                  } else {
                    return const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
