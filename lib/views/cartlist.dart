import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/discountcontroller.dart';
import 'package:flutter_car_application/datastore.dart';
import 'package:flutter_car_application/views/paymentpanel.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    var totalPrice = 0.0;
    var discountString = "";
    InformationStore.isCartOrder = false;
    InformationStore.discountPercentage = 0.0;
    InformationStore.cartPrice = 0.0;
    InformationStore.finalPrice = 0.0;
    DiscountController discountController = DiscountController();

    for (var car in InformationStore.cartItems) {
      totalPrice += car.carPrice!;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Cart Lists")),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          InformationStore.cartItems.isEmpty ? Container() : Text("TOTAL PRICE: $totalPrice \$"),
          const SizedBox(
            height: 20,
          ),
          InformationStore.cartItems.isEmpty
              ? Container()
              : TextField(
                  decoration: const InputDecoration(label: Text("Enter discount coupon")),
                  onChanged: (value) => discountString = value,
                ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(InformationStore.cartItems[index].carName!),
                subtitle: Text("Price ${InformationStore.cartItems[index].carPrice}\$"),
                trailing: IconButton(
                    onPressed: () {
                      InformationStore.cartItems.removeAt(index);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete)),
              );
            },
            itemCount: InformationStore.cartItems.length,
          ),
          const SizedBox(
            height: 10,
          ),
          InformationStore.cartItems.isEmpty
              ? const Text("Your cart is empty ")
              : ElevatedButton(
                  onPressed: () async {
                    if (discountString.isNotEmpty) {
                      if (!(await discountController.couponExist(discountString))) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid discount")));
                        return;
                      } else {
                        final discountModel = await discountController.getDiscountInfo(discountString);
                        InformationStore.discountPercentage = discountModel.percent!;
                      }
                    }
                    InformationStore.cartPrice = totalPrice;
                    InformationStore.isCartOrder = true;
                    InformationStore.finalPrice = totalPrice - (totalPrice * (InformationStore.discountPercentage / 100.00));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPanel()));
                  },
                  child: const Text("Confirm your orders")),
        ],
      ),
    );
  }
}
