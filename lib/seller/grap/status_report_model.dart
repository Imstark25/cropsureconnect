class YearlyReportData {
  final int year;
  final double growthRate;       // Percentage
  final double investmentRate;   // Percentage of revenue
  final double fertilizerPurchaseRate; // Percentage of investment

  YearlyReportData({
    required this.year,
    required this.growthRate,
    required this.investmentRate,
    required this.fertilizerPurchaseRate,
  });
}