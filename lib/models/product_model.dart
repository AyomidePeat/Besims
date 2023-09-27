class ProductModel {
  final String category;
  final String paymentMethod;
  final String customerName;
  final String productName;
  final String stockQty;
  final String unitPrice;
  final String quantity;
  final String seller;

  ProductModel( {
    required this.category,
    required this.paymentMethod,
    required this.customerName,
    required this.productName,
    required this.stockQty,
    required this.unitPrice,
    required this.quantity,
   required this.seller,
  });

  Map<String, dynamic> toJson() => {
        'category': category,
        'paymentMethod': paymentMethod,
        'customerName': customerName,
        'productName': productName,
        'stockQty': stockQty,
        'unitPrice': unitPrice,
        'quantity': quantity
      };

  factory ProductModel.getModelFromJson(Map<String, dynamic> json) {
    return ProductModel(
      seller :json['seller'],
        category: json['category'],
        paymentMethod: json['paymentMethod'],
        customerName: json['customerName'],
        productName: json['productName'],
        stockQty: json['stockQty'],
        unitPrice: json['unitPrice'],
        quantity: json['quantity']);
  }
}
