class MarketRateModel {
  final String cropName;
  final String price;
  final String city;

  // Constructor: Jo data ko pack karega
  MarketRateModel({
    required this.cropName,
    required this.price,
    required this.city,
  });

  // Factory Method: Jo Django ke JSON ko Flutter ke Model mein badlega
  factory MarketRateModel.fromJson(Map<String, dynamic> json) {
    return MarketRateModel(
      cropName: json['crop_name'],
      price: json['price'].toString(), // Price ko string mein badal raha hai safety ke liye
      city: json['city'],
    );
  }
}