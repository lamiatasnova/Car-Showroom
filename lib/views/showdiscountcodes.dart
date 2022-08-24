import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/discountcontroller.dart';
import 'package:flutter_car_application/models/discountmodel.dart';

class ShowDiscountCodes extends StatelessWidget {
  const ShowDiscountCodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DiscountController discountController = DiscountController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discount codes"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: discountController.showDisounts(),
          builder: (context, AsyncSnapshot<List<DiscountModel>> snapshot) {
            if (snapshot.hasData) {
              final couponList = snapshot.data!;
              return ListView.builder(
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text("Discount coupon code: ${couponList[index].coupon!}"),
                    subtitle: Text("Discount percent: ${couponList[index].percent}%"),
                  );
                }),
                itemCount: couponList.length,
              );
            } else {
              return const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));
            }
          }),
    );
  }
}
