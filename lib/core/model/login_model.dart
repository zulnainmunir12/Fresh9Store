

import 'package:fresh9_rider/core/model/user_info_model.dart';

class LoginModel {
  final bool success;
  final UserInfoModel userInfo;
  final String token;
  final String serverError;

  LoginModel({
    this.success,
    this.userInfo,
    this.token,
    this.serverError,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'],
      userInfo: json['user'] != null
          ? UserInfoModel.fromJson(json['user'])
          : null,
      token: json['message'] is String ? null :json['message']['token']
    );
  }

  factory LoginModel.withError(String serverError) =>
      LoginModel(serverError: serverError);
}


//{
//"suucess": true,
//"message": {
//"email": "raxi.akbar@hotmail.com",
//"token": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJheGkuYWtiYXJAaG90bWFpbC5jb20iLCJpZCI6IjVmY2UwOTc0OWViNzg2NzE4MWExYWMxMCIsImlhdCI6MTYwODU0MzkzMCwiZXhwIjoxNjA4NTQ3NTMwfQ.zIy4fcSIIYQ0nfm4MFfRYQa4yifn4xKR2sy-YZuNEik",
//"refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJheGkuYWtiYXJAaG90bWFpbC5jb20iLCJpZCI6IjVmY2UwOTc0OWViNzg2NzE4MWExYWMxMCIsImlhdCI6MTYwODU0MzkzMCwiZXhwIjoxNjA4NTUxMTMwfQ.YQvz8tzZTJcTbBFGIhtFGi7Uont54iRT4Y16NSa8PlQ",
//"tokenExpiresIn": 3600,
//"refreshTokenExpiresIn": 7200
//},
//"user":
//}