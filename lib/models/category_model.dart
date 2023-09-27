class CategoryModel {
  final String categoryName;

  CategoryModel({required this.categoryName});

  Map<String, dynamic> toJson() => {'categoryName': categoryName};

  factory CategoryModel.getModelFromJson(Map<String, dynamic> json) {
    return CategoryModel(categoryName: json['categoryName']);
  }
}
