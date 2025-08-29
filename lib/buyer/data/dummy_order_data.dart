import 'package:cropsureconnect/buyer/models/order_model.dart';

final List<OrderModel> dummyOrders = [
  // --- NEW PRE-BOOKED ORDERS ---
  OrderModel(
    id: '#PBK-2025-0001',
    cropName: 'Egyptian Oranges',
    quantityTons: 100, // For the max filter
    originCountry: 'Egypt',
    supplier: 'Nile Delta Exports',
    status: OrderStatus.preBooked,
    deliveryDate: DateTime(2025, 12, 5),
  ),
  OrderModel(
    id: '#PBK-2025-0002',
    cropName: 'Kenyan Avocados',
    quantityTons: 8, // For the min filter
    originCountry: 'Kenya',
    supplier: 'Rift Valley Growers',
    status: OrderStatus.preBooked,
    deliveryDate: DateTime(2025, 11, 20),
  ),
  // --- Existing Orders ---
  OrderModel(
    id: '#ORD-2025-0012',
    cropName: 'Basmati Rice',
    quantityTons: 2000,
    originCountry: 'India',
    supplier: 'Farmer Cooperative #7',
    status: OrderStatus.inTransit,
    deliveryDate: DateTime(2025, 8, 28),
  ),
  OrderModel(
    id: '#ORD-2025-0011',
    cropName: 'Organic Apples',
    quantityTons: 500,
    originCountry: 'Spain',
    supplier: 'Barcelona Coop',
    status: OrderStatus.delivered,
    deliveryDate: DateTime(2025, 8, 12),
  ),
  OrderModel(
    id: '#ORD-2025-0010',
    cropName: 'Milling Wheat',
    quantityTons: 10000,
    originCountry: 'USA',
    supplier: 'Kansas Agri Group',
    status: OrderStatus.pending,
    deliveryDate: DateTime(2025, 9, 15),
  ),
  OrderModel(
    id: '#ORD-2025-0009',
    cropName: 'Soybean Meal',
    quantityTons: 3000,
    originCountry: 'Brazil',
    supplier: 'Mato Grosso Farmers',
    status: OrderStatus.cancelled,
    deliveryDate: DateTime(2025, 7, 20),
  ),
];