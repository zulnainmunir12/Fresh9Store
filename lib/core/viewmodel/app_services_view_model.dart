import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/viewmodel/reactive_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:stacked/stacked.dart';

class AppServicesViewModel extends ReactiveBaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final CartService _cartService = locator<CartService>();

  int _subTotal = 0, _discount = 0, _deliveryFee = 0, _grandTotal = 0;

  int get subTotal => _subTotal;
  int get discount => _discount;
  int get grandTotal => _grandTotal;
  int get deliveryFee => _deliveryFee;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_cartService, _authService];


}
