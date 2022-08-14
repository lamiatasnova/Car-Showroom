import 'package:flutter/material.dart';
import 'package:flutter_car_application/controllers/data_store.dart';
import 'package:flutter_car_application/views/payment_panel.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart Lists")),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(InformationStore.cartItems[index]),
                trailing: IconButton(
                    onPressed: () {
                      InformationStore.cartItems.removeAt(index);
                      setState(() {
                        
                      });
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
                  onPressed: () {
                    InformationStore.isCartOrder = true;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPanel()));
                  },
                  child: const Text("Confirm your orders")),
        ],
      ),
    );
  }
}
