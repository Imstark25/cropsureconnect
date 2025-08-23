enum OrderStatus { pending, inTransit, delivered, cancelled }

class OrderModel {
  final String id;
  final String cropName;
  final int quantityTons;
  final String originCountry;
  final String supplier;
  final OrderStatus status;
  final DateTime deliveryDate;

  OrderModel({
    required this.id,
    required this.cropName,
    required this.quantityTons,
    required this.originCountry,
    required this.supplier,
    required this.status,
    required this.deliveryDate,
  });
}