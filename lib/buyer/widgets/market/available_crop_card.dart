import 'package:cropsureconnect/buyer/models/market_crop_model.dart';
// ...existing code...
import 'package:cropsureconnect/buyer/views/request_quote_screen.dart';
import 'package:cropsureconnect/buyer/widgets/market/certification_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: Image.asset(
                      crop.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image,
                            size: 50, color: Colors.grey);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${crop.name} (${crop.variety})',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Origin: ${crop.farmer.mainCrop}',
                          style: TextStyle(color: Colors.grey[600])),
                      Text('By: ${crop.farmer.name}',
                          style:
                          TextStyle(color: Colors.grey[600], fontSize: 12)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: crop.certifications
                            .map((cert) => CertificationBadge(label: cert))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
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
                      // Get.to(() => PreBookOrderScreen(crop: crop)); // Broken reference removed
                    } else {
                      Get.to(() => RequestQuoteScreen(crop: crop));
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