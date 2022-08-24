import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    OrderModel({
        this.carName,
        this.orderStatus,
        this.userEmail,
    });

    String? carName;
    String? orderStatus;
    String? userEmail;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        carName: json["carName"],
        orderStatus: json["orderStatus"],
        userEmail: json["userEmail"],
    );

    Map<String, dynamic> toJson() => {
        "carName": carName,
        "orderStatus": orderStatus,
        "userEmail": userEmail,
    };
}
