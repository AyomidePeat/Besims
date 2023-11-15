class StockInventoryModel {
  final String name;
  final String expiryDate;
  final String sellingPrice;
  final String costPrice;
  final String quantity;
  final String supplier;
  final String category;
  final String status;
    final  dateAdded;


  StockInventoryModel(
      {required this.name,
      required this.expiryDate,
      required this.sellingPrice,
      required this.costPrice,
      required this.quantity,
      required this.supplier,
      required this.category,
      required this.status,
      required this.dateAdded});

  Map<String, dynamic> toJson() => {
        'name': name,
        'expiryDate': expiryDate,
        'costPrice': costPrice,
        'sellingPrice': sellingPrice,
        'quantity': quantity,
        'supplier': supplier,
        'category': category,
        'status': status,
        'dateAdded':dateAdded
      };

  factory StockInventoryModel.getModelFromJson(Map<String, dynamic> json) {
    return StockInventoryModel(
        name: json['name'],
        expiryDate: json['expiryDate'],
        sellingPrice: json['sellingPrice'],
        supplier: json['supplier'],
        category: json['category'],
        costPrice: json['costPrice'],
        quantity: json['quantity'],
        dateAdded:json['dateAdded'],
        status: json['status']);
  }
}
