import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/discountcontroller.dart';

class AddDiscount extends StatelessWidget {
  const AddDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String coupon = "";
    String percent = "";
    DiscountController discountController = DiscountController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add discount"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Enter discount code"),
          TextField(
            onChanged: (value) => coupon = value,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Enter percent"),
          TextField(
            onChanged: (value) => percent = value,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                // add discount
                if (coupon.isEmpty || percent.isEmpty || double.tryParse(percent) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong input. Use right input")));
                } else {
                  await discountController.createDiscount(context, coupon, double.tryParse(percent)!);
                }
              },
              child: const Text("Submit")),
        ],
      ),
    );
  }
}
