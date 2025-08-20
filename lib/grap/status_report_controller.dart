import 'package:cropsureconnect/grap/status_report_model.dart';
import 'package:get/get.dart';


class StatusReportController extends GetxController {
  var isLoading = true.obs;
  var reportData = <YearlyReportData>[].obs;
  var selectedYearIndex = 0.obs; // To track which year is highlighted

  @override
  void onInit() {
    super.onInit();
    fetchReportData();
  }

  void fetchReportData() async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    // Sample data for the radar chart
    reportData.value = [
      YearlyReportData(year: 2023, growthRate: 60, investmentRate: 40, fertilizerPurchaseRate: 50),
      YearlyReportData(year: 2024, growthRate: 80, investmentRate: 70, fertilizerPurchaseRate: 60),
      YearlyReportData(year: 2025, growthRate: 75, investmentRate: 55, fertilizerPurchaseRate: 80),
    ];
    selectedYearIndex.value = reportData.length - 1; // Select the latest year by default
    isLoading(false);
  }

  void selectYear(int index) {
    selectedYearIndex.value = index;
  }
}