class MarketCropModel {
  final String imagePath;
  final String name;
  final String variety;
  final String originCountry;
  final String farmerInfo;
  final List<String> certifications;
  final int availableVolumeTons;
  final double? pricePerTon;
  final bool isNegotiable;
  final bool isPreBook;

  MarketCropModel({
    required this.imagePath,
    required this.name,
    required this.variety,
    required this.originCountry,
    required this.farmerInfo,
    required this.certifications,
    required this.availableVolumeTons,
    this.pricePerTon,
    this.isNegotiable = false,
    this.isPreBook = false,
  });
}