import 'package:cropsureconnect/buyer/models/market_crop_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreBookOrderController extends GetxController {
  final MarketCropModel crop;
  PreBookOrderController({required this.crop});

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers
  late final TextEditingController quantityController;
  late final TextEditingController advanceAmountController;

  // --- NEW: Reactive variable to manage the quantity state ---
  // We use this as the "single source of truth" for the quantity.
  // Set an initial default value, perhaps 1.0 tons.
  final RxDouble selectedQuantityInTons = 1.0.obs;

  // Reactive state variables
  final RxBool isEscrowSelected = true.obs;
  final RxBool termsAccepted = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize the text controller with the default reactive value
    quantityController = TextEditingController(text: selectedQuantityInTons.value.toString());
    advanceAmountController = TextEditingController();

    // --- NEW: Add a listener ---
    // This syncs the text field input BACK to the reactive variable.
    quantityController.addListener(_onQuantityTextChanged);
  }

  @override
  void onClose() {
    // Clean up the listener and controllers
    quantityController.removeListener(_onQuantityTextChanged);
    quantityController.dispose();
    advanceAmountController.dispose();
    super.onClose();
  }

  // --- NEW: Listener function ---
  void _onQuantityTextChanged() {
    // When the user types, try to parse the text into a double
    final double? typedValue = double.tryParse(quantityController.text);

    // If the text is a valid number AND it's different from our current state, update the state.
    if (typedValue != null && typedValue != selectedQuantityInTons.value) {
      // We use update() here instead of .value = to prevent a feedback loop (which would re-run the listener).
      // Or simply check the value first as done above.
      selectedQuantityInTons.value = typedValue;
    }
  }

  // --- NEW: Methods for your UI filter buttons ---
  // You can call these methods from your new UI widgets (like + or - buttons).

  /// Sets the quantity directly (e.g., from a dropdown or preset filter chips)
  void setQuantity(double newQuantity) {
    if (newQuantity <= 0) return; // Prevent zero or negative

    selectedQuantityInTons.value = newQuantity;
    // Update the text controller to match the new value
    quantityController.text = newQuantity.toString();
  }

  /// Increments the quantity (e.g., by 0.5 tons)
  void incrementQuantity() {
    // You can customize the increment step (e.g., 0.5 tons, 1 ton)
    double step = 0.5;
    setQuantity(selectedQuantityInTons.value + step);
  }

  /// Decrements the quantity
  void decrementQuantity() {
    double step = 0.5;
    double newQuantity = selectedQuantityInTons.value - step;

    // Ensure it doesn't go below a minimum (e.g., the step amount)
    if (newQuantity >= step) {
      setQuantity(newQuantity);
    } else {
      // If decrementing brings it too low, just set it to the minimum step
      setQuantity(step);
    }
  }


  // Logic to proceed with the payment
  Future<void> proceedToPayment() async {
    // First, validate the form fields
    if (!formKey.currentState!.validate()) {
      Get.snackbar("Input Error", "Please fill all required fields correctly.");
      return;
    }

    // Second, check if terms and conditions are accepted
    if (!termsAccepted.value) {
      Get.snackbar("Agreement Required", "You must accept the terms and conditions to proceed.");
      return;
    }

    // --- NEW: Optional check ---
    // Make sure they have selected a valid quantity greater than 0
    if (selectedQuantityInTons.value <= 0) {
      Get.snackbar("Input Error", "Quantity must be greater than 0 tons.");
      return;
    }

    isLoading.value = true;

    // --- MOCK PAYMENT LOGIC ---
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.defaultDialog(
      title: "Pre-Booking Successful!",
      // --- UPDATED: Use the reactive variable for confirmation ---
      middleText: "Your pre-booking for ${selectedQuantityInTons.value} tons of ${crop.name} has been confirmed.",
      textConfirm: "OK",
      onConfirm: () {
        // Navigate back two screens to the market list after success
        Get.back(); // Close the dialog
        Get.back(); // Go back from the pre-book screen
      },
    );
  }
}