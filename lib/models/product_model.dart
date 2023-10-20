class ProductModel {
  final String category;
  final String paymentMethod;
  final String status;
  final String productName;
  final String stockQty;
  final String unitPrice;
  final String quantity;
  final String seller;

  ProductModel( {
    required this.category,
    required this.paymentMethod,
    required this.status,
    required this.productName,
    required this.stockQty,
    required this.unitPrice,
    required this.quantity,
   required this.seller,
  });

  Map<String, dynamic> toJson() => {
        'category': category,
        'paymentMethod': paymentMethod,
        'status': status,
        'productName': productName,
        'stockQty': stockQty,
        'unitPrice': unitPrice,
        'quantity': quantity,
        'seller':seller
      };

  factory ProductModel.getModelFromJson(Map<String, dynamic> json) {
    return ProductModel(
      seller :json['seller'],
        category: json['category'],
        paymentMethod: json['paymentMethod'],
        status: json['status'],
        productName: json['productName'],
        stockQty: json['stockQty'],
        unitPrice: json['unitPrice'],
        quantity: json['quantity']);
  }
}
