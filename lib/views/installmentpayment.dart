import 'package:flutter/material.dart';

class InstallmentPayment extends StatelessWidget {
  const InstallmentPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment methods"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("data")],
        ),
      ),
    );
  }
}
