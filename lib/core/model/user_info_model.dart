import 'package:fresh9_rider/core/model/address_model.dart';

class UserInfoModel {
  String store, role, cell, imageUrl, id, fullname, email, createdAt;
  List users, rights;
  List addresses;
  int wallet, voucher;
  List<Address> addressesList;
  final serverError;

  UserInfoModel(
      {this.email,
      this.serverError,
      this.imageUrl,
      this.createdAt,
      this.id,
      this.addresses,
      this.addressesList,
      this.cell,
      this.fullname,
      this.voucher,
      this.rights,
      this.role,
      this.wallet,
      this.store});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
        id: json['_id'],
        createdAt: json['createdAt'],
        email: json['email'],
        voucher: json['voucher'],
        addresses: json['addresses'],
        addressesList: json['addresses'] == null
            ? null
            : List<Address>.from(json['addresses'].map(
                (x) => Address.fromJson(x),
              )),
        cell: json['cell'],
        fullname: json['fullname'],
        imageUrl: json['imageUrl'],
        rights: json['rights'],
        role: json['role'],
        wallet: json['wallet'],
        store: json['store']);
  }

  factory UserInfoModel.withError(String serverError) =>
      UserInfoModel(serverError: serverError);
}
