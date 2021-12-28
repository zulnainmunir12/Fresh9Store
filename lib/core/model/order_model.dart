import 'package:fresh9_rider/core/model/product.dart';

class OrderModel {
//  {"products":[{"id":"60a36bf0dca05c3d57a47567","name":"Banana","quantity":1,"discountedPrice":10,"retailPrice":120}],
//  "orderStatus":"delivered","_id":"60dada2e19ac2b43b4a8c40b","deliveryAddress":"Hadi St, Central Park Housing Scheme, Lahore, Punjab, Pakistan",
//  "pickupAddress":"central park","customerName":"Usman Sukhera 2","customerMobile":"+923017316943","storeNumber":"03017316943","store":"6085479d37e6f748f7a9e55f",
//  "total":40,"storeName":"Fresh9 Central Park","storeLocation":{"latitude":"31.320882039180884","longitude":"74.3848831276723"},
//  "userLocation":[31.324422113741434,74.38427668064833],"userId":"60bdf52b376dda1ddbacb37a","createdAt":"2021-06-29T08:30:38.141Z","updatedAt":"2021-08-18T19:29:32.704Z","__v":0}

  List<Product> products;
  final serverError;
  var wallet;
  List userLocation;
  String orderStatus,
      orderType,
      id,
      title,
      instructions,
      deliveryAddress,
      pickupAddress,
      customerName,
      customerMobile,
      storeNumber,
      store,
      storeName,
      userId,
      createdAt,
      updatedAt;
  int total;
  Map storeLocation;

  OrderModel(
      {this.products,
      this.id,
      this.store,
      this.wallet,
      this.instructions,
      this.serverError,
      this.storeName,
      this.createdAt,
      this.userId,
      this.title,
      this.orderType,
      this.customerMobile,
      this.customerName,
      this.deliveryAddress,
      this.orderStatus,
      this.pickupAddress,
      this.storeLocation,
      this.storeNumber,
      this.total,
      this.updatedAt,
      this.userLocation});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        products: List<Product>.from(json['products'].map(
          (x) => Product.fromJson(x),
        )).toList(),
        updatedAt: json['updatedAt'],
        createdAt: json['createdAt'],
        storeName: json['storeName'],
        id: json['_id'],
        instructions: json['instructions'],
        title: json['title'],
        wallet: json['wallet'],
        orderType: json['orderType'],
        userId: json['userId'],
        orderStatus: json['orderStatus'],
        store: json['store'],
        customerMobile: json['customerMobile'],
        customerName: json['customerName'],
        deliveryAddress: json['deliveryAddress'],
        pickupAddress: json['pickupAddress'],
        storeLocation: json['storeLocation'],
        storeNumber: json['storeNumber'],
        total: json['total'],
        userLocation: json['userLocation']);
  }

  factory OrderModel.withError(String serverError) =>
      OrderModel(serverError: serverError);
}
