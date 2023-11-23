class CategoryModel {
  final String categoryName;
  final  dateCreated;

  CategoryModel( {required this.categoryName, required this.dateCreated,});

  Map<String, dynamic> toJson() => {'categoryName': categoryName, 'dateCreated':dateCreated};

  factory CategoryModel.getModelFromJson(Map<String, dynamic> json) {
    return CategoryModel(categoryName: json['categoryName'], dateCreated :json['dateCreated']);
  }
}
