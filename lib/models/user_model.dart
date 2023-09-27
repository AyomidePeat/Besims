

class UserModel {
  final String name;
  final String username;
  final String email;
  final String role;

  UserModel(
      {required this.name,required this.username,required this.email,required this.role, });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
       'username':username,
       'role':role
      };

  factory UserModel.getModelFromJson(Map<String, dynamic> json) {
    return UserModel(
     email: json['email'],
     name: json['name'],
     role: json['role'],
     username: json['username']

    );
  }
}
