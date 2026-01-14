class Product {
  String id;
  String name;
  String description;
  double originalPrice;
  double sellingPrice;
  int yearsUsed;
  String category;
  String condition;
  String sellerId;
  String sellerName;
  List<String> images;
  DateTime listedDate;
  bool isAvailable;
  String size;
  String brand;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.sellingPrice,
    required this.yearsUsed,
    required this.category,
    required this.condition,
    required this.sellerId,
    required this.sellerName,
    required this.images,
    required this.listedDate,
    required this.isAvailable,
    required this.size,
    required this.brand,
  });
}
