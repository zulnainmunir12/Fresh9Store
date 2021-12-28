import 'package:fresh9_rider/core/model/store_model.dart';

class Product {
  List keyWords;
  var increment,
      inventory,
      retailPrice,
      purchasePrice,
      discountedPrice,
      maxQuantity,
      minQuantity,
      quantity,
      orderQuantity,
      productType;
  final String serverError;
  String unit,
      imageUrl,
      subTitle,
      description,
      name,
      category,
      subCategory,
      storeId,
      id;
  StoreModel store;
  bool featuredProduct;

  Product(
      {this.id,
      this.store,
      this.storeId,
      this.imageUrl,
      this.subTitle,
      this.orderQuantity,
      this.description,
      this.quantity,
      this.name,
      this.inventory,
      this.category,
      this.discountedPrice,
      this.featuredProduct,
      this.increment,
      this.keyWords,
      this.maxQuantity,
      this.minQuantity,
      this.productType,
      this.purchasePrice,
      this.serverError,
      this.retailPrice,
      this.subCategory,
      this.unit});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        inventory: json['inventory'],
        subTitle: json['subTitle'],
        id: json['_id'],
        imageUrl: json['imageUrl'],
        description: json['description'],
        storeId: json['storeId'] is String || json['storeId'] == null
            ? json['storeId']
            : StoreModel.fromJson(json['storeId']).id,
        store: json['storeId'] is String || json['storeId'] == null
            ? null
            : StoreModel.fromJson(json['storeId']),
        name: json['name'],
        quantity: json['quantity'],
        category: json['category'],
        discountedPrice: json['discountedPrice'],
        featuredProduct: json['featuredProduct'],
        increment: json['increment'],
        keyWords: json['keyWords'],
        maxQuantity: json['maxQuantity'],
        minQuantity: json['minQuantity'],
        productType: json['productType'],
        purchasePrice: json['purchasePrice'],
        retailPrice: json['retailPrice'],
        subCategory: json['subCategory'],
        unit: json['unit'],
        orderQuantity: 0);
  }

  factory Product.withError(String serverError) =>
      Product(serverError: serverError);
}
