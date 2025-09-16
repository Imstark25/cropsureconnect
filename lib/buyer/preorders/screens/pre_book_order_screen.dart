import 'package:cropsureconnect/buyer/models/market_crop_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pre_book_order_controller.dart';

class PreBookOrderScreen extends StatelessWidget {
  final MarketCropModel crop;
  const PreBookOrderScreen({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreBookOrderController(crop: crop));

    return Scaffold(
      appBar: AppBar(
        title: Text("Pre-Book ${crop.name}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.quantityController,
                decoration: const InputDecoration(
                  labelText: "Quantity (tons)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.advanceAmountController,
                decoration: const InputDecoration(
                  labelText: "Advance Amount (₹)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              Obx(() => CheckboxListTile(
                value: controller.termsAccepted.value,
                onChanged: (val) =>
                controller.termsAccepted.value = val ?? false,
                title: const Text("I accept the terms and conditions"),
              )),
              const SizedBox(height: 16),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: controller.proceedToPayment,
                child: const Text("Proceed to Payment"),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
