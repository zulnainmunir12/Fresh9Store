class StoreModel {
  String cuisineType,
      menuId,
      businessType,
      cell,
      landline,
      imageUrl,
      subTitle,
      id,
      storeName,
      adminId,
      email,
      address,
      city,
      country,
      state,
      contactPerson;
  final serverError;
  bool ownDelivery, breakStatus;
  int minimumOrder, deliveryFee, commision, deliveryRange;
  Map timing, location;

  StoreModel(
      {this.cell,
      this.imageUrl,
      this.serverError,
      this.email,
      this.address,
      this.id,
      this.deliveryRange,
      this.subTitle,
      this.state,
      this.adminId,
      this.businessType,
      this.city,
      this.commision,
      this.contactPerson,
      this.country,
      this.cuisineType,
      this.deliveryFee,
      this.landline,
      this.menuId,
      this.minimumOrder,
      this.ownDelivery,
      this.storeName,
      this.location,
      this.breakStatus,
      this.timing});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
        imageUrl: json['imageUrl'],
        cell: json['cell'],
        email: json['email'],
        id: json['_id'],
        subTitle: json['subTitle'],
        address: json['address'],
        adminId: json['adminId'],
        businessType: json['businessType'],
        city: json['city'],
        commision: json['commision'],
        contactPerson: json['contactPerson'],
        country: json['country'],
        cuisineType: json['cuisineType'],
        deliveryFee: json['deliveryFee'],
        landline: json['landline'],
        menuId: json['menuId'],
        minimumOrder: json['minimumOrder'],
        ownDelivery: json['ownDelivery'],
        state: json['state'],
        storeName: json['storeName'],
        location: json['location'],
        breakStatus: json['break'],
        deliveryRange: json['deliveryRange'],
        timing: json['timing']);
  }

  factory StoreModel.withError(String serverError) =>
      StoreModel(serverError: serverError);
}
