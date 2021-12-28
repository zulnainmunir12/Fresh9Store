class Service {
  bool active;
  List<dynamic> storeAssocicated, storeName;
  int deliveryRange;
  final serverError;
  String id, name, description, imageUrl, createdAt, updatedAt;

  Service(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.storeName,
      this.createdAt,
      this.serverError,
      this.active,
      this.deliveryRange,
      this.storeAssocicated,
      this.updatedAt});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
        imageUrl: json['imageUrl'],
        name: json['name'],
        description: json['description'],
        id: json['id'],
        storeName: json['storeName'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        active: json['active'],
        deliveryRange: json['deliveryRange'],
        storeAssocicated: json['storeAssocicated']);
  }

  factory Service.withError(String serverError) =>
      Service(serverError: serverError);
}
