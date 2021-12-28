import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:observable_ish/observable_ish.dart';

class ProfileViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  RxValue<UserInfoModel> _userInfoModel = RxValue<UserInfoModel>();
  bool loader = false;
  UserInfoModel _userInfo;
  UserInfoModel get userInfoModel => _userInfo;
  final Api _api = locator<Api>();

  ProfileViewModel() {
    getUser();
  }

  update(String name, String email) async {
    if (email.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email))
      Fluttertoast.showToast(
          msg: "Kindly enter valid email address.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    else {
      print(_userInfo.id);
      loader = true;
      notifyListeners();
      SharedPreferences sharedPreference =
          await SharedPreferences.getInstance();
      String token = await sharedPreference.get(SharedPreference.token);
      LoginModel response = await _api.updateProfile(
          {"fullname": name, "email": email}, _userInfo.id, token);
      _userInfo = response.userInfo;

      loader = false;
      notifyListeners();
    }
  }

  getUser() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = await sharedPreference.get(SharedPreference.token);
    _userInfo = _authService.userInfoModel;
    LoginModel response = await _api.getProfile(_userInfo.id, token);
    _userInfo = response.userInfo;
    nameController.text = _userInfo.fullname;
    emailController.text = _userInfo.email;
    setState(ViewState.idle);
  }
}
