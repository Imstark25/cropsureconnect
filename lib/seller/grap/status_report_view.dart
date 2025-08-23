import 'package:cropsureconnect/seller/grap/status_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fl_chart/fl_chart.dart';

class StatusReportView extends StatelessWidget {
  const StatusReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final StatusReportController controller = Get.put(StatusReportController());
    final Color primaryColor = Colors.green.shade700;
    final Color secondaryColor = Colors.purple.shade700;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Status Report'),
        backgroundColor: context.theme.appBarTheme.backgroundColor,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Yearly Performance Analysis",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Tap a year below to see its performance breakdown.",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 300,
                child: RadarChart(
                  RadarChartData(
                    dataSets: _buildChartDataSets(controller),
                    radarBackgroundColor: Colors.transparent,
                    borderData: FlBorderData(show: false),
                    radarBorderData: const BorderSide(color: Colors.grey, width: 2),
                    tickBorderData: const BorderSide(color: Colors.grey, width: 1),
                    gridBorderData: const BorderSide(color: Colors.grey, width: 1),
                    ticksTextStyle: const TextStyle(color: Colors.grey, fontSize: 10),
                    getTitle: (index, angle) {
                      switch (index) {
                        case 0:
                          return const RadarChartTitle(text: 'Growth', angle: 0);
                        case 1:
                          return const RadarChartTitle(text: 'Investment', angle: 90);
                        case 2:
                          return const RadarChartTitle(text: 'Fertilizer Use', angle: 180);
                        default:
                          return const RadarChartTitle(text: '');
                      }
                    },
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 400),
                ),
              ),
              const SizedBox(height: 24),
              _buildYearSelector(controller),
            ],
          ),
        );
      }),
    );
  }

  List<RadarDataSet> _buildChartDataSets(StatusReportController controller) {
    return controller.reportData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final isSelected = index == controller.selectedYearIndex.value;

      return RadarDataSet(
        fillColor: (isSelected ? Colors.green : Colors.purple).withOpacity(0.2),
        borderColor: (isSelected ? Colors.green : Colors.purple),
        borderWidth: isSelected ? 4.0 : 2.0,
        entryRadius: isSelected ? 5 : 3,
        dataEntries: [
          RadarEntry(value: data.growthRate),
          RadarEntry(value: data.investmentRate),
          RadarEntry(value: data.fertilizerPurchaseRate),
        ],
      );
    }).toList();
  }

  Widget _buildYearSelector(StatusReportController controller) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.reportData.length,
        itemBuilder: (context, index) {
          final year = controller.reportData[index].year.toString();
          final isSelected = index == controller.selectedYearIndex.value;
          return GestureDetector(
            onTap: () => controller.selectYear(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300),
                boxShadow: isSelected
                    ? [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 10, spreadRadius: 2)]
                    : [],
              ),
              child: Center(
                child: Text(
                  year,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}