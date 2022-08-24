import 'package:flutter_car_application/models/carmodel.dart';

class InformationStore {
  static String currentCarSelectedName = "";
  static double discountPercentage = 0;
  static double cartPrice = 0;
  static double finalPrice = 0;
  static List<CarModel> cartItems = [];
  static bool isCartOrder = false;
  static List<String> carCategory = [
    "sports","suv","coupe","sedan","others"
  ];
  static String currentPreference = "sports";
}
