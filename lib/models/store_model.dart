class StoreModel {
  final String name;
  final String manager;
  final String location;
  final String phone;
  final String status;

  StoreModel({
    required this.name,
    required this.manager,
    required this.location,
    required this.phone,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'manager': manager,
        'location': location,
        'phone': phone,
        'status': status
      };

  factory StoreModel.getModelFromJson(Map<String, dynamic> json) {
    return StoreModel(
        name: json['name'],
        manager: json['manager'],
        location: json['location'],
        phone: json['phone'],
        status: json['status']);
  }
}
