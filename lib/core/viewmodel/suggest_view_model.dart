import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:observable_ish/observable_ish.dart';

class SuggestViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  TextEditingController cityController = new TextEditingController();
  TextEditingController areaController = new TextEditingController();
  TextEditingController productController = new TextEditingController();
  TextEditingController suggestionController = new TextEditingController();
  bool loader = false;
  UserInfoModel get userInfoModel => _authService.userInfoModel;
  final Api _api = locator<Api>();

  submit(String city, String area, String item, String suggestion) async {
    if (city.isEmpty || suggestion.isEmpty)
      Fluttertoast.showToast(
          msg: "All fields are required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    else {
      loader = true;
      notifyListeners();
      SharedPreferences sharedPreference =
          await SharedPreferences.getInstance();
      String token = await sharedPreference.get(SharedPreference.token);
      LoginModel response = await _api.submitSuggestion({
        "city": city,
        "area": area,
        "item": item,
        "suggestion": suggestion,
        "userId": userInfoModel.id,
        "name": userInfoModel.fullname
      }, token);
//      _userInfo = response.userInfo;
      if (response.success) {
        Fluttertoast.showToast(
            msg: "Thanks for you valuable feedback",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        areaController.clear();
        cityController.clear();
        suggestionController.clear();
        productController.clear();
        _navigationService.goBack();
      }

      loader = false;
      notifyListeners();
    }
  }
}
