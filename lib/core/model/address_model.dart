//{loc: [31.483857793151877, 74.31604765355587], address: Plot 111 E, Block E Model Town, Lahore, Punjab, Pakistan, type: Work, instructions: ghhhjo, houseNumber: ujh}
class Address {
  List location;
  String address, instructions, type, houseNumber;
  final String serverError;

  Address(
      {this.address,
      this.location,
      this.type,
      this.houseNumber,
      this.serverError,
      this.instructions});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        address: json['address'],
        location: json['loc'],
        type: json['type'],
        houseNumber: json['houseNumber'],
        instructions: json['instructions']);
  }

  factory Address.withError(String serverError) =>
      Address(serverError: serverError);
}
