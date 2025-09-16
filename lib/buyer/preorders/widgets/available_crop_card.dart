import 'package:cropsureconnect/buyer/models/market_crop_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/pre_book_order_screen.dart';

class AvailableCropCard extends StatelessWidget {
  final MarketCropModel crop;
  const AvailableCropCard({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              crop.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              crop.description ?? "No description",
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Available Volume',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text('${crop.availableVolumeTons} tons',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (crop.isPreBook) {
                      Get.to(() => PreBookOrderScreen(crop: crop));
                    } else {
                      Get.snackbar("Info",
                          "Request Quote functionality is not yet implemented.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    crop.isPreBook ? Colors.blue : Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(crop.isPreBook ? 'Pre-Book' : 'Request Quote'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
