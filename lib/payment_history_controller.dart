import 'package:cropsureconnect/payment_history_model.dart';


import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PaymentHistoryController extends GetxController {
  var isLoading = true.obs;
  var transactions = <PaymentTransaction>[].obs;
  var totalBalance = 24562.00.obs; // Add a total balance

  @override
  void onInit() {
    super.onInit();
    fetchPaymentHistory();
  }

  void fetchPaymentHistory() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 1));

      // New sample data to match the UI
      transactions.value = [
        PaymentTransaction(
          id: 'TXN1001',
          partyName: 'Salem Farmers Co.',
          partyImageUrl: 'https://picsum.photos/seed/salem/200/200',
          description: 'Received Money',
          amount: 2750.00,
          date: DateTime(2025, 8, 18, 10, 30),
          status: TransactionStatus.completed,
          isCredit: true,
        ),
        PaymentTransaction(
          id: 'TXN1002',
          partyName: 'Yercaud Spice Inc.',
          partyImageUrl: 'https://picsum.photos/seed/yercaud/200/200',
          description: 'Sent Money',
          amount: 4000.00,
          date: DateTime(2025, 8, 15, 14, 0),
          status: TransactionStatus.completed,
          isCredit: false,
        ),
        PaymentTransaction(
          id: 'TXN1003',
          partyName: 'Erode Traders',
          partyImageUrl: 'https://picsum.photos/seed/erode/200/200',
          description: 'Received Money',
          amount: 3000.00,
          date: DateTime(2025, 7, 25, 9, 0),
          status: TransactionStatus.completed,
          isCredit: true,
        ),
        PaymentTransaction(
          id: 'TXN1004',
          partyName: 'Subash',
          partyImageUrl: 'https://i.pravatar.cc/150?u=subash',
          description: 'Cashout',
          amount: 15000.00,
          date: DateTime(2025, 8, 25, 18, 0),
          status: TransactionStatus.pending,
          isCredit: false,
        ),
      ];
    } finally {
      isLoading(false);
    }
  }
}