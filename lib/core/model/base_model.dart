class BaseModel {
  final String serverError;
  final dynamic body;

  BaseModel({this.serverError, this.body});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(body: json['body']);
  }

  factory BaseModel.withError(String serverError) =>
      BaseModel(serverError: serverError);
}
