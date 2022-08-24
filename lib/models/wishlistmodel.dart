import 'dart:convert';

WishlistModel wishlistModelFromJson(String str) => WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
    WishlistModel({
        this.email,
        this.carName,
    });

    String? email;
    String? carName;

    factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        email: json["email"],
        carName: json["carName"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "carName": carName,
    };
}
