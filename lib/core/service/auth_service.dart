import 'dart:async';
import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:observable_ish/observable_ish.dart';
//import 'package:quiznoscr/core/model/auth/common/customer_info_model.dart';
//import 'package:quiznoscr/core/model/auth/login_model.dart';
//import 'package:quiznoscr/core/model/auth/password_model.dart';
//import 'package:quiznoscr/core/model/auth/register_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:stacked/stacked.dart';

class AuthService with ReactiveServiceMixin {
  final Api _api = locator<Api>();

  RxValue<UserInfoModel> _userInfoModel = RxValue<UserInfoModel>();

  AuthService() {
    listenToReactiveValues([_userInfoModel]);
  }
//
  UserInfoModel get userInfoModel => _userInfoModel.value;
//
  addUserDataToService(UserInfoModel customerInfoModel) {
    _userInfoModel.value = customerInfoModel;
    notifyListeners();
  }
//
//  Future<RegisterModel> registerCustomer(Map data) async {
//    var registrationData = await _api.registerCustomer(data);
//    if (registrationData.serverError == null) {
//      if (registrationData.error == null) {
//        _customerInfoModel.value = registrationData.customerInfo;
//      }
//    }
//    notifyListeners();
//    return registrationData;
//  }
//
  Future<LoginModel> loginCustomer(Map data) async {
    var loginData = await _api.login(data);
    print("success");
    print(loginData.success);
    if (loginData.success != null) {
      if (loginData.success) {
        _userInfoModel.value = loginData.userInfo;
      }
    }
    notifyListeners();
    return loginData;
  }

  Future<LoginModel> signUp(Map data) async {
    var loginData = await _api.signup(data);
    print("success");
    print(loginData.success);
    if (loginData.success != null) {
      if (loginData.success) {
        _userInfoModel.value = loginData.userInfo;
      }
    }
    notifyListeners();
    return loginData;
  }
//
//  Future<UserModel> getUserInfo(String token) async {
//    var userData = await _api.getCustomerInfo(token);
//    if (userData.serverError == null) {
//      if (userData.error == null) {
//        _customerInfoModel.value = userData.customerInfo;
//      }
//    }
//    notifyListeners();
//    return userData;
//  }
//
//  Future<PasswordModel> forgotPassword(String email) async {
//    var forgotPasswordData = await _api.forgotPassword(email);
//    notifyListeners();
//    return forgotPasswordData;
//  }
//
//  Future<PasswordModel> changePassword(
//      String oldPassword, String password, String confirm, String key) async {
//    var changePasswordData =
//        await _api.changePassword(oldPassword, password, confirm, key);
//    notifyListeners();
//    return changePasswordData;
//  }

  clearAuthService() {
    _userInfoModel.value = null;
    notifyListeners();
  }
}
