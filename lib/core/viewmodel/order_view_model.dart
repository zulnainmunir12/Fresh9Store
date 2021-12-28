import 'dart:convert';
import 'package:fresh9_rider/core/model/base_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final Api _api = locator<Api>();
  UserInfoModel _userInfoModel;
  UserInfoModel get userInfoModel => _userInfoModel;
  List orderList;

  OrderViewModel() {
    getMyOrders();
  }

  navigateToAppServices() {
    _navigationService.navigateToAndClearAll(NavigationRouter.appServices);
  }

  getMyOrders() async {
    setState(ViewState.loading);
    _userInfoModel = _authService.userInfoModel;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
    BaseModel response = await _api.getMyOrders(token, _userInfoModel.id);
    if (response.serverError == null) {
//        String response = response.;
      orderList = jsonDecode(response.body);
      orderList.forEach((element) {
        print(element['_id']);
        print(element['orderStatus']);
      });
      //storeName
      setState(ViewState.idle);
    } else
      setState(ViewState.error);
  }

  cancelOrder(String orderId) async {
    setState(ViewState.loading);
    _userInfoModel = _authService.userInfoModel;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
    BaseModel response = await _api.cancelOrder(token, orderId);
    setState(ViewState.idle);
    //storeName
    getMyOrders();
  }
}
