import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/seller/controller/farmer_profile_controller.dart';
import 'package:cropsureconnect/seller/views/edit_farmer_profile_view.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';

import '../models/farmer_profile_model.dart';

class FarmerProfileView extends StatelessWidget {
  const FarmerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final FarmerProfileController controller = Get.put(FarmerProfileController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text('Farmer Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note, color: Colors.black),
            tooltip: 'Edit Profile',
            onPressed: () => Get.to(() => const EditFarmerProfileView()),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.farmerProfile.value == null) {
          return const Center(child: Text('Could not load profile.'));
        }

        final profile = controller.farmerProfile.value!;
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildProfileHeader(profile),
            const SizedBox(height: 16),
            _buildQuickStats(profile),
            const SizedBox(height: 16),
            _buildCropProgressCard(controller, profile),
            const SizedBox(height: 16),
            _buildFarmingPracticesCard(profile),
            const SizedBox(height: 16),
            _buildExportHistoryChart(profile),
            const SizedBox(height: 16),
            _buildDocumentsCard(controller, profile.documents),
          ],
        );
      }),
    );
  }

  // --- ALL HELPER METHODS ARE NOW CORRECTLY INSIDE THE CLASS ---

  Widget _buildProfileHeader(FarmerProfile profile) {
    final imageFile = profile.localProfileImage;
    ImageProvider<Object> imageProvider;
    if (imageFile != null) {
      imageProvider = FileImage(imageFile);
    } else if (profile.profileImageUrl != null && profile.profileImageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(profile.profileImageUrl!);
    } else {
      imageProvider = const AssetImage('assets/placeholder.png');
    }
    final verifiedBadges = profile.documents.where((doc) => doc.isVerified).toList();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 40, backgroundImage: imageProvider),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(profile.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    ...verifiedBadges.map((badge) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Tooltip(
                        message: '${badge.type} Certified',
                        child: const Icon(Icons.verified, color: Colors.green, size: 20),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 4),
                Text('ID: ${profile.farmerId}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                Text('Phone: ${profile.phoneNumber}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(FarmerProfile profile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(Icons.landscape, "${profile.acres} Acres", "Land Holding"),
        _buildStatItem(Icons.eco, "${profile.capacityInTonnes} Tonnes", "Capacity"),
        _buildStatItem(Icons.star, "${profile.rating} / 5.0", "Rating"),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.green, size: 30),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildFarmingPracticesCard(FarmerProfile profile) {
    return _buildInfoCard(
      title: "Farming Practices",
      icon: Icons.agriculture,
      children: [
        _buildDetailRow("Current Plantation", profile.currentPlantedCrop),
        _buildDetailRow("Previous Crops", profile.previousCrops.join(', ')),
        _buildDetailRow("Farming Type", profile.farmingType),
        _buildDetailRow("Fertilizers Used", profile.fertilizerUsed),
      ],
    );
  }

  Widget _buildExportHistoryChart(FarmerProfile profile) {
    final Map<String, double> yearlyAvgRating = {};
    final groupedByYear = groupBy(profile.exportHistory, (ExportRecord record) => record.year);

    groupedByYear.forEach((year, records) {
      double totalRating = records.fold(0, (sum, record) => sum + record.rating);
      yearlyAvgRating[year] = totalRating / records.length;
    });

    final sortedYears = yearlyAvgRating.keys.toList()..sort();

    return _buildInfoCard(
      title: "Export Performance",
      icon: Icons.bar_chart,
      children: [
        SizedBox(
          height: 180,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 5,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => Colors.blueGrey,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final year = sortedYears[group.x.toInt()];
                    return BarTooltipItem(
                      '$year\n',
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: rod.toY.toStringAsFixed(1),
                          style: const TextStyle(
                              color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const TextSpan(
                          text: ' avg rating',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12),
                        )
                      ],
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(sortedYears[value.toInt()],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      );
                    },
                    reservedSize: 38,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              barGroups: sortedYears.asMap().entries.map((entry) {
                final index = entry.key;
                final year = entry.value;
                final avgRating = yearlyAvgRating[year]!;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: avgRating,
                      color: Colors.green,
                      width: 22,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCropProgressCard(FarmerProfileController controller, FarmerProfile profile) {
    return _buildInfoCard(
      title: "Current Crop Progress",
      icon: Icons.grass,
      actionButton: IconButton(
        icon: const Icon(Icons.camera_alt, color: Colors.green),
        tooltip: 'Add Weekly Report',
        onPressed: () => controller.addCropProgressReport(),
      ),
      children: [
        Text(
          profile.currentPlantedCrop,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: Obx(() {
            final reports = controller.farmerProfile.value!.cropProgressReports;
            if (reports.isEmpty) {
              return const Center(child: Text("No progress reports yet."));
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return _buildReportItem(reports[index]);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildReportItem(CropProgressReport report) {
    ImageProvider<Object> imageProvider;
    if (report.localImageFile != null) {
      imageProvider = FileImage(report.localImageFile!);
    } else {
      imageProvider = NetworkImage(report.imageUrl);
    }

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image(
              image: imageProvider,
              height: 80,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(
                    width: 100,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('MMM d').format(report.reportDate),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard(FarmerProfileController controller, List<Document> documents) {
    return _buildInfoCard(
      title: "Documents & Certificates",
      icon: Icons.folder_copy,
      actionButton: IconButton(
        icon: const Icon(Icons.add_circle, color: Colors.green),
        tooltip: 'Upload New Document',
        onPressed: () => controller.pickDocumentForType('Uncategorized'),
      ),
      children: documents.isEmpty
          ? [const Center(child: Text('No documents uploaded yet.'))]
          : documents.map((doc) => _buildDocumentRow(doc)).toList(),
    );
  }

  Widget _buildDocumentRow(Document doc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.description, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Expanded(child: Text(doc.name, style: const TextStyle(fontSize: 16))),
          if (doc.isVerified)
            const Icon(Icons.check_circle, color: Colors.green, size: 20)
          else
            const Text('Pending', style: TextStyle(color: Colors.orange)),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required IconData icon, required List<Widget> children, Widget? actionButton}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              if (actionButton != null) actionButton,
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}