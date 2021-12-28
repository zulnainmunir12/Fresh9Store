import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  bool _currentPasswordVisibility = false;

  bool get currentPasswordVisibility => _currentPasswordVisibility;

  changeCurrentPasswordVisibility() {
    _currentPasswordVisibility = !_currentPasswordVisibility;
    notifyListeners();
  }

  bool _enableFingerPrint = false;

  get enableFingerPrint => _enableFingerPrint;

  setFingerPrint(bool value) {
    _enableFingerPrint = value;
    notifyListeners();
  }

  login(String phone, Map accountData,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    Map<String, dynamic> data = {
      "cell": phone,
    };
    setState(ViewState.loading);
    LoginModel loginModelData = await _authService.loginCustomer(data);
    if (loginModelData.serverError == null) {
      if (loginModelData.success) {
        print("Successfully Logged In");
        await saveToken(loginModelData.token);
        _navigationService.navigateToAndClearAll(NavigationRouter.appServices);
      } else {
        print(accountData);
        if(accountData == null)
          accountData = {"phone": phone};
        else
             accountData["phone"] = phone;
        setState(ViewState.idle);
        await saveToken(loginModelData.token);
        _navigationService.navigateToAndClearAll(NavigationRouter.signUpScreen,
            arguments: accountData);
//        final snackBar = SnackBar(content: Text("User not found"));
//        scaffoldKey.currentState.showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(content: Text("User not found"));
      scaffoldKey.currentState.showSnackBar(snackBar);
      setServerError(loginModelData.serverError);
      setState(ViewState.error);
    }
  }

  saveToken(String token) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.remove(SharedPreference.token);
    await sharedPreference.setString(
      SharedPreference.token,
      token,
    );
    print("Saved token - $token");
  }

  onTapLogin() {
    _navigationService.navigateTo(NavigationRouter.enterNumberScreen);
  }

  onTapForgotPassword() {
//    _navigationService.navigateToAndBack(NavigationRouter.);
  }
}
