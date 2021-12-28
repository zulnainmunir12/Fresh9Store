import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  bool loader = false;
  UserInfoModel _userInfo;
  UserInfoModel get userInfoModel => _userInfo;
  final Api _api = locator<Api>();

  WalletViewModel() {
    getUser();
  }

  getUser() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = await sharedPreference.get(SharedPreference.token);
    _userInfo = _authService.userInfoModel;
    LoginModel response = await _api.getProfile(_userInfo.id, token);
    _userInfo = response.userInfo;
    setState(ViewState.idle);
  }
}
