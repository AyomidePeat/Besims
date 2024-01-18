class UserModel {
  final String name;
  final String username;
  final String email;
  final String role;
  final String image;
  final String phoneNumber;
  final String gender;

  UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.image,
    required this.phoneNumber,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'username': username,
        'role': role,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'image': image
      };

  factory UserModel.getModelFromJson({required Map<String, dynamic> json}) {
    return UserModel(
        email: json['email'],
        gender: json['gender'],
        name: json['name'],
        role: json['role'],
        username: json['username'],
        image: json['image'],
        phoneNumber: json['phoneNumber']);
  }
}
