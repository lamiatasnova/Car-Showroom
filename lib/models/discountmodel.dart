import 'dart:convert';

DiscountModel discountModelFromJson(String str) => DiscountModel.fromJson(json.decode(str));

String discountModelToJson(DiscountModel data) => json.encode(data.toJson());

class DiscountModel {
    DiscountModel({
        this.coupon,
        this.percent,
    });

    String? coupon;
    double? percent;

    factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        coupon: json["coupon"],
        percent: json["percent"],
    );

    Map<String, dynamic> toJson() => {
        "coupon": coupon,
        "percent": percent,
    };
}
