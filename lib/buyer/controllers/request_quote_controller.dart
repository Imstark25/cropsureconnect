import 'package:cropsureconnect/buyer/models/contract_model.dart';
import 'package:cropsureconnect/buyer/models/market_crop_model.dart';
import 'package:cropsureconnect/buyer/views/contract_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Enum to represent the payment options
enum PaymentMethod { escrow, upi }

class RequestQuoteController extends GetxController {
  final MarketCropModel crop;
  RequestQuoteController({required this.crop});

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controller for payment terms text field
  late final TextEditingController paymentTermsController;

  // --- STATE MANAGEMENT ---
  // Manages the quantity selected by the user
  final RxDouble quantityInTons = 1.0.obs;
  // Manages which payment method is currently selected
  final Rx<PaymentMethod> selectedPaymentMethod = PaymentMethod.escrow.obs;

  @override
  void onInit() {
    super.onInit();
    paymentTermsController = TextEditingController();
  }

  @override
  void onClose() {
    paymentTermsController.dispose();
    super.onClose();
  }

  /// Increments the quantity by one ton.
  void incrementQuantity() {
    quantityInTons.value += 1.0;
  }

  /// Decrements the quantity by one ton, with a minimum of 1.
  void decrementQuantity() {
    if (quantityInTons.value > 1.0) {
      quantityInTons.value -= 1.0;
    }
  }

  /// Updates the state when a new payment method is selected.
  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod.value = method;
  }

  /// Validates user input, creates a contract, and navigates to the contract screen.
  void submitRequest() {
    // 1. First, validate the form to ensure payment terms are filled.
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        "Input Error",
        "Please fill in all required fields.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 2. Create a mock Importer Profile.
    // In a real application, this data would come from the logged-in user's profile.
    final mockImporter = ImporterProfile(
      importerId: 'I-4589',
      companyName: 'FreshGlobal Imports Ltd.',
      location: 'Dubai, UAE',
    );

    // 3. Assemble the contract data from the crop and user inputs.
    final contractData = ContractModel(
      // In a real app, generate this dynamically (e.g., using a timestamp)
      contractRefNo: 'CC-CRN-2025-0914-${DateTime.now().millisecond}',
      contractDate: DateTime.now(),
      crop: crop,
      farmer: crop.farmer,
      importer: mockImporter,
      quantityTons: quantityInTons.value,
      // Use the crop's price if available, otherwise use a default value.
      unitPrice: crop.pricePerTon ?? 1200,
      // Set a mock delivery date for the example.
      deliveryDate: DateTime.now().add(const Duration(days: 300)),
      portOfDelivery: 'Jebel Ali Port, Dubai',
      paymentTermsSummary:
      'Funds held in CropsureConnect Escrow, released upon shipment confirmation.',
    );

    // 4. Navigate to the new Contract Screen, passing the generated contract data.
    Get.to(() => ContractScreen(contract: contractData));
  }
}