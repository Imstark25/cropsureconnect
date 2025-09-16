import 'package:get/get.dart';
import 'package:cropsureconnect/buyer/models/market_crop_model.dart';

class Order {
  final MarketCropModel crop;
  final String quantity;
  final String advance;

  Order({
    required this.crop,
    required this.quantity,
    required this.advance,
  });
}

class OrdersController extends GetxController {
  final RxList<Order> orders = <Order>[].obs;

  void addOrder({
    required MarketCropModel crop,
    required String quantity,
    required String advance,
  }) {
    orders.add(Order(crop: crop, quantity: quantity, advance: advance));
  }
}
