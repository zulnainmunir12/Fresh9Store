import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/reactive_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:stacked/stacked.dart';

class DrawerViewModel extends ReactiveBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final CartService _cartService = locator<CartService>();
  final AuthService _authService = locator<AuthService>();

  UserInfoModel get userInfoModel => _authService.userInfoModel;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_cartService, _authService];


  navigateToPage(String route){
    _navigationService
        .navigateToAndBack(route);
  }

  logoutNavigate(String route){
    _navigationService
        .navigateToAndClearAll(route);
  }

}