import 'package:cropsureconnect/buyer/controllers/request_quote_controller.dart';
import 'package:cropsureconnect/buyer/models/market_crop_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestQuoteScreen extends StatelessWidget {
  final MarketCropModel crop;
  const RequestQuoteScreen({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    final RequestQuoteController controller =
    Get.put(RequestQuoteController(crop: crop));
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Quote'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCropInfoCard(context, crop),
              const SizedBox(height: 24),
              _buildFarmerDetailsCard(context, crop),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Quantity Needed'),
              _buildQuantitySelector(context, controller),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Preferred Payment Method'),
              _buildPaymentMethodSelector(context, controller),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Proposed Payment Terms'),
              TextFormField(
                controller: controller.paymentTermsController,
                decoration: InputDecoration(
                  hintText: 'e.g., "50% advance, 50% on delivery"',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your proposed payment terms.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle:
            textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          onPressed: controller.submitRequest,
          child: const Text('Send Quote Request'),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCropInfoCard(BuildContext context, MarketCropModel crop) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                crop.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(crop.name,
                      style: Theme.of(context).textTheme.titleLarge),
                  Text('Variety: ${crop.variety}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('Origin: ${crop.farmer.mainCrop}',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmerDetailsCard(BuildContext context, MarketCropModel crop) {
    final farmer = crop.farmer;
    return Card(
      child: ExpansionTile(
        leading: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        title: Text(farmer.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
  subtitle: Text('Seller'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
        _buildFarmerDetailRow(context, Icons.star, 'Rating',
          '${farmer.rating}'),
        _buildFarmerDetailRow(context, Icons.eco, 'Fertilizer', farmer.fertilizerUsed),
        _buildFarmerDetailRow(context, Icons.public, 'Main Crop', farmer.mainCrop),
                _buildFarmerDetailRow(
                    context, Icons.article, 'Farmer ID', farmer.farmerId),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFarmerDetailRow(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(
      BuildContext context, RequestQuoteController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tons', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: controller.decrementQuantity,
                ),
                Text(
                  controller.quantityInTons.value.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: controller.incrementQuantity,
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildPaymentMethodSelector(
      BuildContext context, RequestQuoteController controller) {
    return Obx(() => Card(
      child: Column(
        children: [
          RadioListTile<PaymentMethod>(
            title: const Text('Secure Escrow Account'),
            subtitle: const Text('Recommended for security'),
            value: PaymentMethod.escrow,
            groupValue: controller.selectedPaymentMethod.value,
            onChanged: (PaymentMethod? value) {
              if (value != null) controller.selectPaymentMethod(value);
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          RadioListTile<PaymentMethod>(
            title: const Text('Direct UPI / Bank Transfer'),
            subtitle: const Text('Faster, direct-to-seller payment'),
            value: PaymentMethod.upi,
            groupValue: controller.selectedPaymentMethod.value,
            onChanged: (PaymentMethod? value) {
              if (value != null) controller.selectPaymentMethod(value);
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    ));
  }
}