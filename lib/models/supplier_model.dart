class SupplierModel {
  final String name;
  final String company;
  final String address;
  final String email;
  final String phone;
  final String date;

  SupplierModel({
    required this.name,
    required this.company,
    required this.address,
    required this.email,
    required this.phone,
    required this.date
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'company': company,
        'address': address,
        'email': email,
        'phone': phone,
        'date':date
      };

  factory SupplierModel.getModelFromJson(Map<String, dynamic> json) {
    return SupplierModel(
        name: json['name'],
        company: json['company'],
        address: json['address'],
        email: json['email'],date:json['date'],
        phone: json['phone']);
  }
}
