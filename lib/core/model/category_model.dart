class Category {
  String imageUrl, id, name, category, categoryId;
  bool showSubCategory;
  final String serverError;

  Category(
      {this.name,
      this.imageUrl,
      this.serverError,
      this.id,
      this.category,
      this.showSubCategory,
      this.categoryId});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['name'],
        imageUrl: json['imageUrl'],
        id: json['_id'],
        category: json['category'],
        categoryId: json['categoryId'],
        showSubCategory: false);
  }

  factory Category.withError(String serverError) =>
      Category(serverError: serverError);
}
