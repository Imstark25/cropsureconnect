// File: lib/buyer/views/contract_screen.dart

import 'package:cropsureconnect/buyer/controllers/contract_controller.dart';
import 'package:cropsureconnect/buyer/models/contract_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

class ContractScreen extends StatelessWidget {
  final ContractModel contract;
  const ContractScreen({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    final ContractController controller =
    Get.put(ContractController(contract: contract));
  // ...existing code...
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Contract Confirmation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildContractMeta(context, contract),
            const Divider(height: 32),

            _buildSectionTitle(context, '1. Parties'),
            _buildPartyDetails(context, 'Farmer / FPO', contract.farmer.name,
                contract.farmer.farmerId),
            _buildPartyDetails(context, 'Importer / Buyer',
                contract.importer.companyName, contract.importer.importerId),
            const SizedBox(height: 16),

            _buildSectionTitle(context, '2. Crop & Commercial Terms'),
            _buildTermRow(context, 'Crop',
                '${contract.crop.name} (${contract.crop.variety})'),
            _buildTermRow(
                context, 'Quantity', '${contract.quantityTons} Metric Tons'),
            _buildTermRow(context, 'Unit Price',
                '${NumberFormat.simpleCurrency(name: 'USD').format(contract.unitPrice)} / MT'),
            _buildTermRow(context, 'Total Value',
                '${NumberFormat.simpleCurrency(name: 'USD').format(contract.totalContractValue)}'),
            _buildTermRow(context, 'Delivery Date',
                DateFormat.yMMMMd().format(contract.deliveryDate)),
            _buildTermRow(
                context, 'Port of Delivery', contract.portOfDelivery),
            const SizedBox(height: 16),

            _buildSectionTitle(context, '3. Payment & Quality Terms'),
            _buildTermRow(context, 'Payment', contract.paymentTermsSummary),
            _buildTermRow(context, 'Quality Standards',
                'APEDA Export Standards Compliant'),
            const SizedBox(height: 16),

            _buildSectionTitle(context, '4. Digital Consent'),
            const Text(
              'By clicking "Submit & Consent", you agree to all terms outlined in this digitally executed E-Contract.',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Download PDF'),
              onPressed: controller.downloadContractAsPdf,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 8),
            Obx(
                  () => ElevatedButton.icon(
                icon: controller.isSubmitting.value
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                    : const Icon(Icons.check_circle),
                label: Text(controller.isSubmitting.value
                    ? 'Submitting...'
                    : 'Submit & Consent'),
                onPressed: controller.isSubmitting.value
                    ? null
                    : controller.submitAndGiveConsent,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets for UI ---

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Text(
        'CropsureConnect Pre-Booking E-Contract',
        style:
        Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContractMeta(BuildContext context, ContractModel contract) {
    return Column(
      children: [
        Text('Ref No: ${contract.contractRefNo}'),
        Text('Date: ${DateFormat.yMMMMd().format(contract.contractDate)}'),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style:
        Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPartyDetails(
      BuildContext context, String role, String name, String id) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(role),
        trailing: Text('ID: $id', style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }

  Widget _buildTermRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text('$label:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}