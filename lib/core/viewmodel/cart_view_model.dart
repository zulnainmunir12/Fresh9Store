import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/model/store_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/reactive_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends ReactiveBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Api _api = locator<Api>();
  final AuthService _authService = locator<AuthService>();
  final CartService _cartService = locator<CartService>();
  StoreModel _deliveryStore;

  int _subTotal = 0,
      _discount = 0,
      _deliveryFee = 0,
      _grandTotal = 0,
      _minimumOrder = 0,
      _wallet = 0;

  int get subTotal => _subTotal;
  int get discount => _discount;
  int get grandTotal => _grandTotal;
  int get deliveryFee => _deliveryFee;
  int get minimumOrder => _minimumOrder;
  int get wallet => _wallet;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_cartService, _authService];

  CartViewModel() {
    getUser();
  }

  getUser() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = await sharedPreference.get(SharedPreference.token);
    UserInfoModel userInfoModel = _authService.userInfoModel;
    LoginModel response = await _api.getProfile(userInfoModel.id, token);
    userInfoModel = response.userInfo;
    _wallet = userInfoModel.wallet + userInfoModel.voucher;
    print("walletttt");
    print(_wallet);
    getSingleStore();
  }

  getSingleStore() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String savedStoreId = sharedPreference.get(SharedPreference.storeId);
    String token = sharedPreference.get(SharedPreference.token);
    _deliveryStore = await _api.getSingleStore(token, savedStoreId);
    getTotals();
    setState(ViewState.idle);
  }

  getTotals() async {
    _subTotal = _discount = _grandTotal = 0;
    _cartService.cartModelDataList.forEach((element) {
      _subTotal += (element.quantity * element.retailPrice);
      _discount += ((element.quantity * element.retailPrice) -
          (element.quantity * element.discountedPrice));
      _grandTotal += (element.quantity * element.discountedPrice);
    });
    _deliveryFee = _deliveryStore.deliveryFee;
    _grandTotal += _deliveryFee;

    _grandTotal -= _wallet;
    _minimumOrder = _deliveryStore.minimumOrder;
    notifyListeners();
  }

  addQuantity(int index) {
    _cartService.addCartQuantity(index);
    getTotals();
  }

  removeItem(int index) {
    _cartService.removeCartOfStream(index);
    getTotals();
  }

  decrementQuantity(int index) {
    _cartService.decrementCartQuantity(index);
    getTotals();
  }

  checkout() {
    Map checkoutMap = {
      "deliveryAddress": "Township",
      "pickupAddress": _deliveryStore.address,
      "customerName": _authService.userInfoModel.fullname,
      "customerMobile": _authService.userInfoModel.cell,
      "storeNumber": _deliveryStore.cell,
      "store": _deliveryStore.id,
      "total": _grandTotal,
      "products": _cartService.cartModelDataList,
      "storeName": _deliveryStore.storeName,
      "userId": _authService.userInfoModel.id,
      "storeLocation": _deliveryStore.location,
      "userLocation": {}
    };
//    _api.login(body)
  }
}
